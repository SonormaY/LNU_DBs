<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xs:element name="product_database">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="product_categories" minOccurs="0" maxOccurs="1">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="product_category" minOccurs="0" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name="id" type="xs:integer"/>
                    <xs:element name="name" type="categoryNameType"/>
                  </xs:sequence>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
        
        <xs:element name="product_titles" minOccurs="0" maxOccurs="1">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="product_title" minOccurs="0" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name="id" type="xs:integer"/>
                    <xs:element name="title" type="titleType"/>
                    <xs:element name="product_category_id" type="xs:integer"/>
                  </xs:sequence>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
        
        <xs:element name="products" minOccurs="0" maxOccurs="1">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="product" minOccurs="0" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name="id" type="xs:integer"/>
                    <xs:element name="product_title_id" type="xs:integer"/>
                    <xs:element name="manufacturer_id" type="xs:integer"/>
                    <xs:element name="price" type="priceType"/>
                    <xs:element name="comment" type="commentType" minOccurs="0"/>
                  </xs:sequence>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>

    <xs:key name="product_category_key">
      <xs:selector xpath="product_categories/product_category"/>
      <xs:field xpath="id"/>
    </xs:key>

    <xs:key name="product_title_key">
      <xs:selector xpath="product_titles/product_title"/>
      <xs:field xpath="id"/>
    </xs:key>

    <xs:keyref name="product_title_category_ref" refer="product_category_key">
      <xs:selector xpath="product_titles/product_title"/>
      <xs:field xpath="product_category_id"/>
    </xs:keyref>

    <xs:keyref name="product_title_ref" refer="product_title_key">
      <xs:selector xpath="products/product"/>
      <xs:field xpath="product_title_id"/>
    </xs:keyref>
  </xs:element>

  <xs:simpleType name="categoryNameType">
    <xs:restriction base="xs:string">
      <xs:maxLength value="50"/>
      <xs:pattern value="[A-Za-z0-9\s]+"/>
    </xs:restriction>
  </xs:simpleType>

  <xs:simpleType name="titleType">
    <xs:restriction base="xs:string">
      <xs:maxLength value="50"/>
      <xs:pattern value="[A-Za-z0-9\s]+"/>
    </xs:restriction>
  </xs:simpleType>

  <xs:simpleType name="priceType">
    <xs:restriction base="xs:decimal">
      <xs:fractionDigits value="2"/>
      <xs:minInclusive value="0"/>
    </xs:restriction>
  </xs:simpleType>

  <xs:simpleType name="commentType">
    <xs:restriction base="xs:string">
      <xs:maxLength value="60"/>
    </xs:restriction>
  </xs:simpleType>

</xs:schema>