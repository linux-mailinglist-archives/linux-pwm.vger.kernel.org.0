Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6D1F18DC
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgFHMgx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 08:36:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13477 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgFHMgw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 08:36:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ede30890000>; Mon, 08 Jun 2020 05:35:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 08 Jun 2020 05:36:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 08 Jun 2020 05:36:51 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jun
 2020 12:36:50 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Jun 2020 12:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHKPN3m2RAmdBMsaxYiEoaA1HdortVDkXP4xExnHbQpopy1+RMbvUMp30dfU/F9vHoNksaD3FxwAJZ/Y0W7fG07F3pC+P//Nnm8XAQcFCfiQrZTCSkk0gpt8+0JV+l58j4VzN23Bzs44WbqITZtgdArx++P1Q9O+rtcnVHgJ75PNcY+cj0YyNqdIgrpwa3BVqIcu9SfJ21FQb06V6LKzHVyM5x2kPC9xzarHRk5T2lx6IVEqiF5b1KGhA55NSWFAGCzISYDWQB04quD0RJM5uNq4cQbe2K/nYCrb5opwpub0X4bs+NVu6Ok2oPdTHR1EBuWDH2UeS2Pud5Fq6VbUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO3HOeXSC/nhLE8wQuoVQCiFIS+whdgrcSKiJfOnb44=;
 b=dHckzXl4RX7ywAgLwb3rgurbq3tbb6e7LkMTwXQ4nvLI1R0T/N7DZvceWpZeH/86BPAuNQ5VHKW/9aZd0tzCWEpK114sGKq6QYmlUYaVOLnK9Z/QEnjZBuR0qT0KMerzR65mICKqQvfkIpvN09ZbHpxnxOk4S8sKyqWs4Z6OOrUtAayaC990mMC1W4DIDyJ4DINcl/fjuCjR2Uxux/lP0VGgMKjb0Ic1W6167sFPT3ReV+rEM2qtbYukgLcuW9V/XAC8kZ/zhF6O0m+SFC2pIispVpsn/cX3FSVkH2j9a70NfUyQj986t/jpn+/7XGUmD4LbvkQb+PidNUas7SeZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB2999.namprd12.prod.outlook.com (2603:10b6:a03:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 12:36:48 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 12:36:48 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Thread-Topic: [PATCH V4] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Thread-Index: AQHWN9Rrs6NPDO5Ks0OwOr2Rbibi1KjHGIoAgAeavVA=
Date:   Mon, 8 Jun 2020 12:36:48 +0000
Message-ID: <BYAPR12MB3014C9298EDC011F4E98BE0FAD850@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
 <20200603162906.vyfynqtxa7mpjxxv@taurus.defre.kleine-koenig.org>
In-Reply-To: <20200603162906.vyfynqtxa7mpjxxv@taurus.defre.kleine-koenig.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-08T12:36:45.1287417Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=a21e6d6a-6987-4eba-9db0-6dd963ba2ece;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [124.123.74.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea1abfd-fbe4-497e-7b02-08d80ba89cb0
x-ms-traffictypediagnostic: BYAPR12MB2999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2999A7102373E04D5ABEC5E1AD850@BYAPR12MB2999.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Chxu5Kc9wTJFrsMKU4Vk1Bxo/NacquRgehdcx1iD4OiAEZh+LYG9TFwtxDMLRjgE5NPS3NH+Ef57gmmXvnUXKJx7nYv2F2NK/CQSlHRSV+tSHRp8pWagNNbR8LWyBAInQJjRxKR1inY1cgPCevOaE8e62+3mZ9Z4przsGpzo2xI3ULBI2b62bfqPrw7ip4GiXR5tRjhLiB8v/YDwuJswNOkMYme3VDZJKMhjMe2wcQrcRnLQKJrPofke4EvzjqZIBdZOTZhm2r8UibS9cYVbGJURC+Pe/muT6pZK0ISvLnf4mJx7yGeNgatd5jaYcpObjgikbJXSZ4wn627Ft3thgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(346002)(396003)(376002)(9686003)(53546011)(6506007)(52536014)(26005)(54906003)(186003)(66574014)(86362001)(7696005)(2906002)(5660300002)(55016002)(478600001)(4326008)(316002)(33656002)(66946007)(64756008)(66556008)(66476007)(83380400001)(8676002)(71200400001)(66446008)(6916009)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5xS+Koj7ZqL5ts0RLFWKGtktnuqM8pHnjfQ0yNLYfSWkqd+B/n8BuDz7g9oNh0I+AtG+1sOG6SdeuUtVIY3JN8FF92rfzNYxGTXnMGxL0/g2Lu/GeVaNBwY685SeGZL8fbYePiOZYOF7k3EjxKuWIq6gKT89FiTWiltJFspikivmQ82mf8xzAj56GQ8YyHVbpCW85rfCXxbLk7NO6upTDdV01vIb+SL8ZZH1YwPR3iFAExTQrDRK0Bhe/TpPAze+XM5Wy+xkzCbTlIQTwUt7S9NDl7hdaPhMg85VaIhNyiaZl3OOZE7Hos3sQq1EnuxnlMm+d4tGRu4TCFDDgspi9kJ6SRh1AXa/+htW7w6STE/YebZKqj09bRIa2SR+Fxm7SiS3j1LiDK7AHEUtebKbS/b6qsYFXNxANjJxlWshIe6OnvGmzEKxZIq2tQVx8xCnp3o7kyy0CjHblV5fsV10gCJS86xO8hOGWmV6lCgVVEE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eea1abfd-fbe4-497e-7b02-08d80ba89cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 12:36:48.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkbiXGhOM+ovwTjtT1fHp7R+YV8Panr7iqdNcmDmKqhhR6qYVEesroyHbgV8SmRy8VdYn26rqXHdm+QCSWptTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591619721; bh=EO3HOeXSC/nhLE8wQuoVQCiFIS+whdgrcSKiJfOnb44=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Vrpdpz1SDHBDoyvbl8UCZHNDnvk+tzIajiIbX3OCQYDSo7vWRU5ltTdfXJR2gPZHE
         CUQa2K+lVSFxoOAcGsM2xsyjOXy4e8a6h9VIr8Q/NS65F09MqTuO3vvOf+4ZxKyfR7
         n8p+2JPEzH/7giM8Xy8UuYqt9MbUZf+QE3+bKcQJPsoXSfxaX4l0D9CiFE74T7M6ub
         V+NQ6l9hOKTugH8q0nRALKwRZT+4tbGIUpGHmkEhAcR+gXq5+4giBMf6D7IZ3+gsJF
         5MEYsdfg45VAu8pXNDZL2ppmgjJ5lIfRNqtfGtVlyFk7+AHeUjJHS2fUHpp5NRQlyr
         307zCdYpR345g==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKdW5lIDMsIDIwMjAgOTo1OSBQTQ0KPiBUbzogU2FuZGlwYW4gUGF0cmEgPHNwYXRy
YUBudmlkaWEuY29tPg0KPiBDYzogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT47
IEpvbmF0aGFuIEh1bnRlcg0KPiA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBCaWJlayBCYXN1IDxi
YmFzdUBudmlkaWEuY29tPjsgTGF4bWFuIERld2FuZ2FuDQo+IDxsZGV3YW5nYW5AbnZpZGlhLmNv
bT47IEtyaXNobmEgWWFybGFnYWRkYSA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT47DQo+IGxpbnV4
LXB3bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNF0gcHdt
OiB0ZWdyYTogZHluYW1pYyBjbGsgZnJlcSBjb25maWd1cmF0aW9uIGJ5IFBXTQ0KPiBkcml2ZXIN
Cj4gDQo+IEhlbGxvLA0KPiANCj4gT24gTW9uLCBKdW4gMDEsIDIwMjAgYXQgMTA6NTA6MzZBTSAr
MDUzMCwgU2FuZGlwYW4gUGF0cmEgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdt
L3B3bS10ZWdyYS5jIGIvZHJpdmVycy9wd20vcHdtLXRlZ3JhLmMgaW5kZXgNCj4gPiBkMjZlZDhm
Li4xZGFmNTkxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS10ZWdyYS5jDQo+ID4g
KysrIGIvZHJpdmVycy9wd20vcHdtLXRlZ3JhLmMNCj4gPiBAQCAtNCw4ICs0LDM2IEBADQo+ID4g
ICAqDQo+ID4gICAqIFRlZ3JhIHB1bHNlLXdpZHRoLW1vZHVsYXRpb24gY29udHJvbGxlciBkcml2
ZXINCj4gPiAgICoNCj4gPiAtICogQ29weXJpZ2h0IChjKSAyMDEwLCBOVklESUEgQ29ycG9yYXRp
b24uDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAxMC0yMDIwLCBOVklESUEgQ29ycG9yYXRpb24u
DQo+ID4gICAqIEJhc2VkIG9uIGFyY2gvYXJtL3BsYXQtbXhjL3B3bS5jIGJ5IFNhc2NoYSBIYXVl
cg0KPiA+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KPiA+ICsgKg0KPiA+ICsgKiBPdmVydmll
dyBvZiBUZWdyYSBQdWxzZSBXaWR0aCBNb2R1bGF0b3IgUmVnaXN0ZXI6DQo+ID4gKyAqIDEuIDEz
LWJpdDogRnJlcXVlbmN5IGRpdmlzaW9uIChTQ0FMRSkNCj4gPiArICogMi4gOC1iaXQgOiBQdWxz
ZSBkaXZpc2lvbiAoRFVUWSkNCj4gPiArICogMy4gMS1iaXQgOiBFbmFibGUgYml0DQo+ID4gKyAq
DQo+ID4gKyAqIFRoZSBQV00gY2xvY2sgZnJlcXVlbmN5IGlzIGRpdmlkZWQgYnkgMjU2IGJlZm9y
ZSBzdWJkaXZpZGluZyBpdA0KPiA+ICsgYmFzZWQNCj4gPiArICogb24gdGhlIHByb2dyYW1tYWJs
ZSBmcmVxdWVuY3kgZGl2aXNpb24gdmFsdWUgdG8gZ2VuZXJhdGUgdGhlDQo+ID4gKyByZXF1aXJl
ZA0KPiA+ICsgKiBmcmVxdWVuY3kgZm9yIFBXTSBvdXRwdXQuIFRoZSBtYXhpbXVtIG91dHB1dCBm
cmVxdWVuY3kgdGhhdCBjYW4gYmUNCj4gPiArICogYWNoaWV2ZWQgaXMgKG1heCByYXRlIG9mIHNv
dXJjZSBjbG9jaykgLyAyNTYuDQo+ID4gKyAqIGUuZy4gaWYgc291cmNlIGNsb2NrIHJhdGUgaXMg
NDA4IE1IeiwgbWF4aW11bSBvdXRwdXQgZnJlcXVlbmN5IGNhbiBiZToNCj4gPiArICogNDA4IE1I
ei8yNTYgPSAxLjYgTUh6Lg0KPiA+ICsgKiBUaGlzIDEuNiBNSHogZnJlcXVlbmN5IGNhbiBmdXJ0
aGVyIGJlIGRpdmlkZWQgdXNpbmcgU0NBTEUgdmFsdWUgaW4gUFdNLg0KPiA+ICsgKg0KPiA+ICsg
KiBQV00gcHVsc2Ugd2lkdGg6IDggYml0cyBhcmUgdXNhYmxlIFsyMzoxNl0gZm9yIHZhcnlpbmcg
cHVsc2Ugd2lkdGguDQo+ID4gKyAqIFRvIGFjaGlldmUgMTAwJSBkdXR5IGN5Y2xlLCBwcm9ncmFt
IEJpdCBbMjRdIG9mIHRoaXMgcmVnaXN0ZXIgdG8NCj4gPiArICogMeKAmWIxLiBJbiB3aGljaCBj
YXNlIHRoZSBvdGhlciBiaXRzIFsyMzoxNl0gYXJlIHNldCB0byBkb24ndCBjYXJlLg0KPiA+ICsg
Kg0KPiA+ICsgKiBMaW1pdGF0aW9uczoNCj4gPiArICogLQlXaGVuIFBXTSBpcyBkaXNhYmxlZCwg
dGhlIG91dHB1dCBpcyBkcml2ZW4gdG8gaW5hY3RpdmUuDQo+ID4gKyAqIC0JSXQgZG9lcyBub3Qg
YWxsb3cgdGhlIGN1cnJlbnQgUFdNIHBlcmlvZCB0byBjb21wbGV0ZSBhbmQNCj4gPiArICoJc3Rv
cHMgYWJydXB0bHkuDQo+ID4gKyAqDQo+IA0KPiBJJ2QgcHJlZmVyIHRvIGhhdmUgbm8gZW1wdHkg
bGluZXMgaW4gdGhlIGluIExpbWl0YXRpb25zIHBhcmFncmFwaCB0byBiZSBhYmxlIHRvIGdldA0K
PiBhbGwgaW5mb3MgdXNpbmcgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJc2VkIC1ybiAnL1wqIExp
bWl0YXRpb25zOi8sL14gXCpcLz8kL3AnIGRyaXZlcnMvcHdtL3B3bS10ZWdyYS5jDQo+IA0KDQpJ
J2xsIHB1c2ggYSBjaGFuZ2UgZm9yIHRoaXMuDQoNCj4gPiArICogLQlJZiB0aGUgcmVnaXN0ZXIg
aXMgcmVjb25maWd1cmVkIHdoaWxlIFBXTSBpcyBydW5uaW5nLA0KPiA+ICsgKglpdCBkb2VzIG5v
dCBjb21wbGV0ZSB0aGUgY3VycmVudGx5IHJ1bm5pbmcgcGVyaW9kLg0KPiA+ICsgKg0KPiA+ICsg
KiAtCUlmIHRoZSB1c2VyIGlucHV0IGR1dHkgaXMgYmV5b25kIGFjY2VwdGlibGUgbGltaXRzLA0K
PiA+ICsgKgktRUlOVkFMIGlzIHJldHVybmVkLg0KPiANCj4gcy9hY2NlcHRpYmxlL2FjY2VwdGFi
bGUvIChidXQgaW4gZmFjdCB0aGlzIGlzbid0IGEgbGltaXRhdGlvbiwgc28gSSdkIGRyb3AgdGhp
cyBoZXJlLA0KPiBhcyBwb2ludGVkIG91dCBpbiB2MikuDQo+IA0KPiBJbiB2MiBJIG1lbnRpb25l
ZCBhIGZldyB0aGluZ3MgdG8gYWRkIGhlcmUuDQoNCk9rLiBVbmRlcnN0b29kLiBJIHdpbGwgbWFr
ZSBzdXJlIHRvIGZvbGxvdyB0aGlzIGluIG5ldyBjaGFuZ2UuDQoNCkluc3RlYWQgb2YgdGhpcw0K
LSBJZiB0aGUgdXNlciBpbnB1dCBkdXR5IGlzIGJleW9uZCBhY2NlcHRpYmxlIGxpbWl0cywNCgkt
RUlOVkFMIGlzIHJldHVybmVkLg0KSSB3aWxsIGFkZCBiZWxvdyBpbmZvIG5vdyBhbmQgZm9sbG93
IHVwIG9uIHRoZSBhdG9taWMgQVBJIGltcGxlbWVudGF0aW9uIGV2ZW50dWFsbHkuDQotIFRoZSBk
cml2ZXIgZG9lc24ndCBpbXBsZW1lbnQgdGhlIHJpZ2h0IHJvdW5kaW5nIHJ1bGVzDQotIFRoZSBk
cml2ZXIgbmVlZHMgdXBkYXRpbmcgdG8gdGhlIGF0b21pYyBBUEkNCg0KPiANCj4gPiAgICovDQo+
ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+IEBAIC00MSw2ICs2OSw3IEBAIHN0
cnVjdCB0ZWdyYV9wd21fY2hpcCB7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCpyc3Q7DQo+
ID4NCj4gPiAgCXVuc2lnbmVkIGxvbmcgY2xrX3JhdGU7DQo+ID4gKwl1bnNpZ25lZCBsb25nIG1p
bl9wZXJpb2RfbnM7DQo+ID4NCj4gPiAgCXZvaWQgX19pb21lbSAqcmVnczsNCj4gPg0KPiA+IEBA
IC02OCw3ICs5Nyw3IEBAIHN0YXRpYyBpbnQgdGVncmFfcHdtX2NvbmZpZyhzdHJ1Y3QgcHdtX2No
aXAgKmNoaXAsDQo+ID4gc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwgIHsNCj4gPiAgCXN0cnVjdCB0
ZWdyYV9wd21fY2hpcCAqcGMgPSB0b190ZWdyYV9wd21fY2hpcChjaGlwKTsNCj4gPiAgCXVuc2ln
bmVkIGxvbmcgbG9uZyBjID0gZHV0eV9ucywgaHo7DQo+ID4gLQl1bnNpZ25lZCBsb25nIHJhdGU7
DQo+ID4gKwl1bnNpZ25lZCBsb25nIHJhdGUsIHJlcXVpcmVkX2Nsa19yYXRlOw0KPiANCj4gSW4g
djIgSSByZXF1ZXN0ZWQgdG8gbW92ZSB0aGlzIGludG8gdGhlIGlmIGJsb2NrIGJlbG93LiBZb3Ug
cmVwbGllZCB0byB3YW50IHRvDQo+IG1vdmUgaXQgYWNjb3JkaW5nbHkuDQoNClRoaXMgZ290IHNr
aXBwZWQuIE15IG1pc3Rha2UuIEkgd2lsbCBwdXNoIGEgY2hhbmdlIHRvIG1vdmUgdGhlIGRlZmlu
aXRpb24gb2YNCnJlcXVpcmVkX2Nsa19yYXRlIGluc2lkZSBpZi1ibG9jayBhcyBhIG5ldyBjaGFu
Z2UuDQoNCj4gDQo+ID4gIAl1MzIgdmFsID0gMDsNCj4gPiAgCWludCBlcnI7DQo+ID4NCj4gPiBA
QCAtODMsOSArMTEyLDQ3IEBAIHN0YXRpYyBpbnQgdGVncmFfcHdtX2NvbmZpZyhzdHJ1Y3QgcHdt
X2NoaXAgKmNoaXAsDQo+IHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQo+ID4gIAl2YWwgPSAodTMy
KWMgPDwgUFdNX0RVVFlfU0hJRlQ7DQo+ID4NCj4gPiAgCS8qDQo+ID4gKwkgKiAgbWluIHBlcmlv
ZCA9IG1heCBjbG9jayBsaW1pdCA+PiBQV01fRFVUWV9XSURUSA0KPiA+ICsJICovDQo+ID4gKwlp
ZiAocGVyaW9kX25zIDwgcGMtPm1pbl9wZXJpb2RfbnMpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiAgCSAqIENvbXB1dGUgdGhlIHByZXNjYWxlciB2YWx1ZSBm
b3Igd2hpY2ggKDEgPDwgUFdNX0RVVFlfV0lEVEgpDQo+ID4gIAkgKiBjeWNsZXMgYXQgdGhlIFBX
TSBjbG9jayByYXRlIHdpbGwgdGFrZSBwZXJpb2RfbnMgbmFub3NlY29uZHMuDQo+ID4gKwkgKg0K
PiA+ICsJICogbnVtX2NoYW5uZWxzOiBJZiBzaW5nbGUgaW5zdGFuY2Ugb2YgUFdNIGNvbnRyb2xs
ZXIgaGFzIG11bHRpcGxlDQo+ID4gKwkgKiBjaGFubmVscyAoZS5nLiBUZWdyYTIxMCBvciBvbGRl
cikgdGhlbiBpdCBpcyBub3QgcG9zc2libGUgdG8NCj4gPiArCSAqIGNvbmZpZ3VyZSBzZXBhcmF0
ZSBjbG9jayByYXRlcyB0byBlYWNoIG9mIHRoZSBjaGFubmVscywgaW4gc3VjaA0KPiA+ICsJICog
Y2FzZSB0aGUgdmFsdWUgc3RvcmVkIGR1cmluZyBwcm9iZSB3aWxsIGJlIHJlZmVycmVkLg0KPiA+
ICsJICoNCj4gPiArCSAqIElmIGV2ZXJ5IFBXTSBjb250cm9sbGVyIGluc3RhbmNlIGhhcyBvbmUg
Y2hhbm5lbCByZXNwZWN0aXZlbHksIGkuZS4NCj4gPiArCSAqIG51bXNfY2hhbm5lbHMgPT0gMSB0
aGVuIG9ubHkgdGhlIGNsb2NrIHJhdGUgY2FuIGJlIG1vZGlmaWVkDQo+ID4gKwkgKiBkeW5hbWlj
YWxseSAoZS5nLiBUZWdyYTE4NiBvciBUZWdyYTE5NCkuDQo+ID4gIAkgKi8NCj4gPiArCWlmIChw
Yy0+c29jLT5udW1fY2hhbm5lbHMgPT0gMSkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogUmF0ZSBp
cyBtdWx0aXBsaWVkIHdpdGggMl5QV01fRFVUWV9XSURUSCBzbyB0aGF0IGl0DQo+IG1hdGNoZXMN
Cj4gPiArCQkgKiB3aXRoIHRoZSBtYXhpbXVtIHBvc3NpYmxlIHJhdGUgdGhhdCB0aGUgY29udHJv
bGxlciBjYW4NCj4gPiArCQkgKiBwcm92aWRlLiBBbnkgZnVydGhlciBsb3dlciB2YWx1ZSBjYW4g
YmUgZGVyaXZlZCBieSBzZXR0aW5nDQo+ID4gKwkJICogUEZNIGJpdHNbMDoxMl0uDQo+IA0KPiBJ
dCBsb29rcyBhIGJpdCBzdHJhbmdlIHRoYXQgdGhlIGFsZ29yaXRobSB0byBjYWxjdWxhdGUgdGhl
IGNsb2NrIHNldHRpbmdzIGRlcGVuZHMNCj4gb24gdGhlIG51bWJlciBvZiBjaGFubmVscy4gTG9v
a3MgbGlrZSBhIHdyb25nIGFic3RyYWN0aW9uLg0KDQpUaGUgY2FsY3VsYXRpb24gaXMgYWRkZWQg
YmFzZWQgb24gbnVtYmVyIG9mIGNoYW5uZWxzIHRvIHN1cHBvcnQgbGVnYWN5IEhXLg0KV2hlbiB0
aGUgUFdNIGNvbnRyb2xsZXIgaGFzIG11bHRpcGxlIGNoYW5uZWxzIGFuZCBhbGwgb2YgdGhlbSBh
cmUgc291cmNlZCBieQ0Kc2luZ2xlIGNsb2NrLCB0aGVuIGR5bmFtaWMgY2xvY2sgY29uZmlndXJh
dGlvbiBjYW4gbm90IGJlIHN1cHBvcnRlZC4gU28gdGhlIGNoYW5nZXMgYXJlDQphbGxvd2VkIG9u
bHkgd2hlbiBQV00gY29udHJvbGxlciBoYXMgb25lIGNoYW5uZWwuDQogDQo+IA0KPiA+ICsJCSAq
DQo+ID4gKwkJICogcmVxdWlyZWRfY2xrX3JhdGUgaXMgYSByZWZlcmVuY2UgcmF0ZSBmb3Igc291
cmNlIGNsb2NrIGFuZA0KPiA+ICsJCSAqIGl0IGlzIGRlcml2ZWQgYmFzZWQgb24gdXNlciByZXF1
ZXN0ZWQgcGVyaW9kLiBCeSBzZXR0aW5nIHRoZQ0KPiA+ICsJCSAqIHNvdXJjZSBjbG9jayByYXRl
IGFzIHJlcXVpcmVkX2Nsa19yYXRlLCBQV00gY29udHJvbGxlciB3aWxsDQo+ID4gKwkJICogYmUg
YWJsZSB0byBjb25maWd1cmUgdGhlIHJlcXVlc3RlZCBwZXJpb2QuDQo+ID4gKwkJICovDQo+ID4g
KwkJcmVxdWlyZWRfY2xrX3JhdGUgPQ0KPiA+ICsJCQkoTlNFQ19QRVJfU0VDIC8gcGVyaW9kX25z
KSA8PCBQV01fRFVUWV9XSURUSDsNCj4gPiArDQo+ID4gKwkJZXJyID0gY2xrX3NldF9yYXRlKHBj
LT5jbGssIHJlcXVpcmVkX2Nsa19yYXRlKTsNCj4gPiArCQlpZiAoZXJyIDwgMCkNCj4gPiArCQkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJCS8qIFN0b3JlIHRoZSBuZXcgcmF0ZSBmb3Ig
ZnVydGhlciByZWZlcmVuY2VzICovDQo+ID4gKwkJcGMtPmNsa19yYXRlID0gY2xrX2dldF9yYXRl
KHBjLT5jbGspOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCXJhdGUgPSBwYy0+Y2xrX3JhdGUgPj4g
UFdNX0RVVFlfV0lEVEg7DQo+ID4NCj4gPiAgCS8qIENvbnNpZGVyIHByZWNpc2lvbiBpbiBQV01f
U0NBTEVfV0lEVEggcmF0ZSBjYWxjdWxhdGlvbiAqLyBAQA0KPiA+IC05NCw3ICsxNjEsNyBAQCBz
dGF0aWMgaW50IHRlZ3JhX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KPiA+IHN0
cnVjdCBwd21fZGV2aWNlICpwd20sDQo+ID4NCj4gPiAgCS8qDQo+ID4gIAkgKiBTaW5jZSB0aGUg
YWN0dWFsIFBXTSBkaXZpZGVyIGlzIHRoZSByZWdpc3RlcidzIGZyZXF1ZW5jeSBkaXZpZGVyDQo+
ID4gLQkgKiBmaWVsZCBtaW51cyAxLCB3ZSBuZWVkIHRvIGRlY3JlbWVudCB0byBnZXQgdGhlIGNv
cnJlY3QgdmFsdWUgdG8NCj4gPiArCSAqIGZpZWxkIHBsdXMgMSwgd2UgbmVlZCB0byBkZWNyZW1l
bnQgdG8gZ2V0IHRoZSBjb3JyZWN0IHZhbHVlIHRvDQo+IA0KPiBJIHdvdWxkIGhhdmUgcHV0IHRo
aXMgaW4gYSBzZXBhcmF0ZSBjaGFuZ2UuDQo+IA0KPiA+ICAJICogd3JpdGUgdG8gdGhlIHJlZ2lz
dGVyLg0KPiA+ICAJICovDQo+ID4gIAlpZiAocmF0ZSA+IDApDQo+ID4gQEAgLTIwNSw2ICsyNzIs
MTAgQEAgc3RhdGljIGludCB0ZWdyYV9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiAqcGRldikNCj4gPiAgCSAqLw0KPiA+ICAJcHdtLT5jbGtfcmF0ZSA9IGNsa19nZXRfcmF0ZShw
d20tPmNsayk7DQo+ID4NCj4gPiArCS8qIFNldCBtaW5pbXVtIGxpbWl0IG9mIFBXTSBwZXJpb2Qg
Zm9yIHRoZSBJUCAqLw0KPiA+ICsJcHdtLT5taW5fcGVyaW9kX25zID0NCj4gPiArCSAgICAoTlNF
Q19QRVJfU0VDIC8gKHB3bS0+c29jLT5tYXhfZnJlcXVlbmN5ID4+DQo+IFBXTV9EVVRZX1dJRFRI
KSkgKw0KPiA+ICsxOw0KPiANCj4gVG8gZW5zdXJlIHRoYXQgcmVxdWlyZWRfY2xrX3JhdGUgaW4g
dGVncmFfcHdtX2NvbmZpZyBkb2Vzbid0IGdldCBiaWdnZXIgdGhhbg0KPiBwd20tPnNvYy0+bWF4
X2ZyZXF1ZW5jeSB0aGlzIGlzbid0IHRoZSByaWdodCBmb3JtdWxhIEkgdGhpbmsuIEknZCB1c2UN
Cj4gDQo+IAlwd20tPm1pbl9wZXJpb2RfbnMgPSBESVZfUk9VTkRVUChOU0VDX1BFUl9TRUMsIHB3
bS0+c29jLQ0KPiA+bWF4X2ZyZXF1ZW5jeSA+PiBQV01fRFVUWV9XSURUSCk7DQo+IA0KPiAuIENh
biB5b3UgY29uZmlybT8NCg0KQXMgcGVyIGZvcm11bGEsICIrMSIgaXMgcmVxdWlyZWQgaW4gdGhl
IGNhbGN1bGF0aW9uLg0KSGVuY2UgdG8gcmVmbGVjdCB0aGlzIGluIHRoZSBjb2RlLCBtYW51YWwg
ZGl2aXNpb24gaXMgZG9uZSB3aGljaCBieSBkZWZhdWx0DQppZ25vcmVzIHRoZSBmcmFjdGlvbmFs
IHBhcnQgb2YgdGhlIGludGVnZXIgZGl2aXNpb24uIEFuZCB0aGVuICsxIGlzIGFkZGVkLg0KDQpZ
b3VyIHN1Z2dlc3Rpb24gdG8gdXNlIERJVl9ST1VORFVQIGlzIGZvciBhIGNyaXNwIGNhbGN1bGF0
aW9uLg0KQnV0IGl0IG1hbmRhdGVzIHRvIGlnbm9yZSAiKzEiIHBhcnQgYXMgdGhlIGRpdmlzaW9u
IGNhbGN1bGF0aW9uIGlzIHRha2VuIGNhcmUgYnkgY29uc2lkZXJpbmcgY2VsbGluZyB2YWx1ZS4N
CldoZW4gdGhlIGRpdmlzaW9uIHlpZWxkcyBxdW90aWVudCB3aXRoIDAgZnJhY3Rpb24sIHRoZW4g
KzEgaXMgbm90IGNvbnNpZGVyZWQuDQoNCkluIHRoaXMgcGF0Y2gsIHJhdyBjYWxjdWxhdGlvbiBp
cyBrZXB0IGZvciBhIGJldHRlciByZWFkYWJpbGl0eSwgd2hpY2ggY2FuIGFsc28gaGVscCB1bmRl
cnN0YW5kaW5nDQphYm91dCB0aGUgYWNjdXJhdGUgZGVyaXZhdGlvbiBvZiBtaW5fcGVyaW9kX25z
IGFzIHBlciBzcGVjaWZpY2F0aW9uLg0KDQpQbGVhc2UgaGVscCBtZSB1bmRlcnN0YW5kaW5nIGlm
IEkgYW0gbm90IGFsaWduZWQgd2l0aCB5b3VyIHN1Z2dlc3Rpb24gYW5kIGlmIGlzIHRoZXJlIGEg
YmV0dGVyDQpjYXNlIHdoZXJlIERJVl9ST1VORFVQIGlzIHJlcXVpcmVkIGluIHRoaXMgY2FzZS4N
Cg0KVGhhbmtzICYgUmVnYXJkcywNClNhbmRpcGFuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBV
d2UNCg==
