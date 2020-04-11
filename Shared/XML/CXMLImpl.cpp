/*****************************************************************************
 *
 *  PROJECT:     Multi Theft Auto
 *  LICENSE:     See LICENSE in the top level directory
 *  FILE:        xml/CXMLImpl.cpp
 *  PURPOSE:     XML handler class
 *
 *  Multi Theft Auto is available from http://www.multitheftauto.com/
 *
 *****************************************************************************/
#include "StdInc.h"

CXMLImpl::CXMLImpl()
{
    // Init array stuff
    CXMLArray::Initialize();
}

CXMLFile* CXMLImpl::CreateXML(const std::string& filename, bool useIDs, bool readOnly)
{
    CXMLFile* xmlFile = new CXMLFileImpl(filename, useIDs, readOnly);
    if (xmlFile->IsValid())
        return xmlFile;
    delete xmlFile;
    return nullptr;
}

void CXMLImpl::DeleteXML(CXMLFile* file)
{
    delete file;
}

CXMLFile* CXMLImpl::CopyXML(const std::string& filename, CXMLNode* node, bool readOnly)
{
    return new CXMLFileImpl(filename, node, readOnly);
}

CXMLNode* CXMLImpl::CreateDummyNode()
{
    pugi::xml_node node;
    node.set_name("dummy_storage");
    return new CXMLNodeImpl(node, false);
}

CXMLAttribute* CXMLImpl::GetAttrFromID(unsigned long ID) const
{
    // Grab it and verify the type
    CXMLCommon* common = CXMLArray::GetEntry(ID);
    if (common && common->GetClassType() == eXMLClass::CXML_ATTR)
        return reinterpret_cast<CXMLAttribute*>(common);

    // Doesn't exist or bad type
    return nullptr;
}

CXMLFile* CXMLImpl::GetFileFromID(unsigned long ID) const
{
    // Grab it and verify the type
    CXMLCommon* common = CXMLArray::GetEntry(ID);
    if (common && common->GetClassType() == eXMLClass::CXML_FILE)
        return reinterpret_cast<CXMLFile*>(common);

    // Doesn't exist or bad type
    return nullptr;
}

CXMLNode* CXMLImpl::GetNodeFromID(unsigned long ID) const
{
    // Grab it and verify the type
    CXMLCommon* common = CXMLArray::GetEntry(ID);
    if (common && common->GetClassType() == eXMLClass::CXML_NODE)
        return reinterpret_cast<CXMLNode*>(common);

    // Doesn't exist or bad type
    return nullptr;
}

CXMLNode* CXMLImpl::ParseString(const char* xmlContent)
{
    // TODO: Rewrite to fix memory leaks
    pugi::xml_document* xmlDoc = new pugi::xml_document();
    if (xmlDoc)
    {
        if (xmlDoc->load_string(xmlContent))
        {
            pugi::xml_node xmlDocumentRoot = xmlDoc->document_element();
            CXMLNodeImpl*  xmlBaseNode = new CXMLNodeImpl(xmlDocumentRoot, true);
            CXMLNode*      xmlRootNode = CXMLImpl::BuildNode(xmlBaseNode, &xmlDocumentRoot);
            return xmlRootNode;
        }
    }
    return nullptr;
}

CXMLNode* CXMLImpl::BuildNode(CXMLNodeImpl* xmlParent, pugi::xml_node* xmlNode)
{
    for (auto& xmlChild : xmlNode->children())
        CXMLImpl::BuildNode(new CXMLNodeImpl(xmlChild, true, xmlParent), &xmlChild);

    return xmlParent;
}
