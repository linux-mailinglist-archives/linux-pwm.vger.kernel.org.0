Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B643C7D24
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 06:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhGNEFe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jul 2021 00:05:34 -0400
Received: from mail-eopbgr1310139.outbound.protection.outlook.com ([40.107.131.139]:11088
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229451AbhGNEFe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 14 Jul 2021 00:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpevQbYndXiNJefA9swnSF3v5xnRMJB75jij2b8QeLhphodaWz0XAFPJs0mX9ACD6/85y4kDLRr2+RD8ENOMgGzN8th8wimWrHKV271xbYyh8z0u9ge4fqzdlZNLN1jXnChr4DZ4kAbrEJPReBS37FUk3MKRPA4JF7MftKx5DNSo5D8UG3vxiMVFD21bpKW9FmHR63KBAOigwQTZqcZNDgLyEDMQrWIseELcpuWGwB/vzNk0T1KyN32BcHo1V7ThxOEjdfGo/gTJ5Pmq6tBK8HzFDywklrnw7YDx1mutXawZieLSSuYyLT2i0ub6zzkSwgtzF2S4S28MRjWvRfwjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vAqyhtNsnX+x1tA1Jf4grJdKn82KPtVsyj6y4gJeik=;
 b=Q6wVYWwbIcEtWIlKdrYPlhggc4/SUEqvD62+kfDGlcHbOi+1UYPVmasfgUpBGzkvQx+ptHSUyYAOCZGXqtnd/S+xRLyazN9S7RfQljf3kUh5HyLxZBcIgYaDgeAvSowfWG9Ol42w62npddE0RN+3wcpe/guPTYbUB6m4doIQRJBbyIZFF4WMeJ6n8Lvu56KoWegJXYPnrK4aWl92BJ6MyRAoJV6miwzn+hxyTEYqw0pFAXuVUMGhih+4/iYN614RN8GDN1zbM2wdKkyaiP45kPfD8KHkad2VPNAfB/8rhwF0rQmPlQYo1nejkWavWPg8ffCHeDzuh99In20/Pt+cnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vAqyhtNsnX+x1tA1Jf4grJdKn82KPtVsyj6y4gJeik=;
 b=cAsVijoNFPMpZZ2uIt5xVEJK6FA+0pMHOUrJCzVN2rx+j5asLZQtCFLh+Um9pfBzVIrrZhnfo4JFILo/J72N2I4KuTOomBGbiaqPBmo6dnSIdF9HCK+zHTWVFjIOlPFXftt/phWqQt8Dbu+2gJCBdZwpdf50sW/z42J6L8Q6hcVdmG/RXLwcW4tQpUE1dcjTCDQ501KbWcYMW7VsNTnOS0PfaCYnhyCFJyDfrWdduCYJzd2mi8iEtnPD6QToGWQzNI11fJ1WQTwtdFsSne/cGMT41mvLAwjn07HTAeV4+QwUawTPYfSf9h5n7R2454JCI3sBdlAyIkFqL9mrA2cx2g==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR06MB3538.apcprd06.prod.outlook.com (2603:1096:202:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 04:02:35 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 04:02:34 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [v9 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHXdI7yKsdmsqvIQUSavJJdmrvZGatBf8qAgADnWgA=
Date:   Wed, 14 Jul 2021 04:02:34 +0000
Message-ID: <029CA29B-1488-4F73-A9E7-FB9BCD0B987F@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-2-billy_tsai@aspeedtech.com>
 <20210713221431.GA936073@robh.at.kernel.org>
In-Reply-To: <20210713221431.GA936073@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec7bdef0-fdc5-45bf-7912-08d9467c362b
x-ms-traffictypediagnostic: HK2PR06MB3538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR06MB35387C661F75DDC09A6653338B139@HK2PR06MB3538.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfOXoqnel+dz4oUqYsJfo/w6bsuBifwfvGkfPAw+GW0K06yCkg9yZfxWiI9ETQMiwhuMnVSwBZT3zKKbYUx4WQ1xjk2yRXfxHUmQEReZ6+xnjE+pb1wuNLjy/IgLEwobhCwQsO8M52F7zrxd/fx9oheaE1+BK6svpm/H/RAkwlR85sulLpYCdCqZd9y6XyzCbLuc99RtOrdAf3frz8o4ULZvsk8igFRJShol65vpeN+sU5XP0oi9U9SZRbf8a88G0OFdIolxhxfLTIc/sp3+djbLJLYrvTHD8fclx2PglnzN8id51/rD6qNPVtwtPAxC+SxT8pY0P8uG52NIUc1VR8EVybxr+wF9QVzhRL3fLVE3/AG2tTarKFytQfQ+w4v+hXLrA9Vxd7KD0lNBkLZX6C+OEc65+q91iaY1tYD8avwPUc4+D6AHDVM3M66VVmtLuBFxpGat56YawzJq/GhaSTN5zusy4TBUHTkFaTQroLN2ET/yUAQ8YOXH/WC7PC9AAfqIqpAK/Mr8d0WCjv9KH/ILYGqkOCzNtTavc83ck+D3+Y9V0SgYw/msIteXPFybd6d8TzyGTBpl6x6LbpmLTHvkLlwaIVx5sOPm9695hntvUxX2S7hOWAdgdKDqw+xDyh1klBfLDWbbtyAsbPnmXpOEmYwj7cNjBsPV560caKssAEEFL6m4dbQP+nr0Gzazkb1+p+bfnK4W5qOvDeIBZPWE+ZO3PDQs+EE20MTLEKhlUVQb1bqyBDvoQmvPCA9GmaJRM5k//ZRKy2uzM79XLQ2aIKQJIv43Te09nBweaZn0nV6XY7+FjVkEL9628Sidnlelnh3f4ag94Hjf+CA9w9lWD920PhCDVjlUPr7WrLA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(136003)(346002)(396003)(366004)(83380400001)(66946007)(6512007)(66446008)(64756008)(6506007)(316002)(86362001)(4326008)(966005)(33656002)(66476007)(53546011)(5660300002)(122000001)(66556008)(76116006)(107886003)(54906003)(2906002)(478600001)(8676002)(7416002)(2616005)(36756003)(186003)(6916009)(6486002)(38100700002)(71200400001)(26005)(55236004)(8936002)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBhZ2pIcngxN2Z1ZTU3WHdaclZVMmZjQ2dMZUUrcmJzSDZJSFYraWJaWTJv?=
 =?utf-8?B?bzA4YkIyTEpnZS9jNmNoNjdnYlAvbEtPSHVxYkMyUWRJYXVadmM1WE1CeWVX?=
 =?utf-8?B?WWlFL2ZmOG1MV2FmSy9IRllISTFNc3lsSWNPdVNXUjlKUHNDSWhwZ1o4eDFP?=
 =?utf-8?B?YmlnWk9Fdm9XSHZoOUNRa3B1eHJCbzBjQ1dzckpjdnJodms2azBFVWxkREFJ?=
 =?utf-8?B?U1gzN1loeVIraVVGV0hXSVhVWVNUaXd4dEFOelN6YmtmemhSQzYzTGJzMmpn?=
 =?utf-8?B?ZTBWN3ZVUVUvbWZ6U3hCbElITTRJdTNCbEF5akZDMWFKWHhhd1UxWkxiVUw0?=
 =?utf-8?B?QmtNSVdjZWpDOFAzeFdkNXpCVlVMbVFiM3FMMzh2UG14Yk9UMngyNFhIdkll?=
 =?utf-8?B?UlNBSUdXcUlFWVRVeW5WeUJMVmJLNG9peXFuRGJqSDZaZEJPSnFaT2hmWW9K?=
 =?utf-8?B?WnRIbjVPV01vTDJBSEJkejZxNjE3Z2dXblpYUFpub2JrZUJYZ2liR1MvQ2lr?=
 =?utf-8?B?Z2R4SVlGdEI3ZWhyamozZTlhMUZjdWlTbTlZY1pWQS9jbi94cklCVFNwVTEx?=
 =?utf-8?B?VEpuWDR4ZW5pQUdOWWRJZ0xoRndqZVdpWWsvMVBLeWU3aVZGZ0J5MnRMRW9P?=
 =?utf-8?B?SUdJcWwxYUcxQUQweTNRb09lL0ZuM1k5SUdvRVZNU2ZQaFRoMGNrTGkrOHVo?=
 =?utf-8?B?Zk83dVFVaXBoU3Zwb0lJZkdvUCtxc2hDYUoyVFpSRUlVTURYTjVESUFTM0JN?=
 =?utf-8?B?OUtDZldZQTg3akxobmZSYmxJaEM1VjU2WGVDN1MzWkRlRHd1bE9jOUVyZDN5?=
 =?utf-8?B?RFRBVXhJS1NuV1VPVzZCUnptR3VHeGZNdmxObVIyRzVvM3J3cFB1a3FROGov?=
 =?utf-8?B?ODlXaWh0Rys5YWVBWXovZW43bzNDK29vUzd2MzRwd0pTcXdOY254V0RiT1Fq?=
 =?utf-8?B?Q010Y0paSzUrdHhITEpqaDZKcXRBUDFyeVFOMnp3V2RiVHNHZHY2WVlUSzln?=
 =?utf-8?B?Njd5YTV6YzZwZ2tZZHduZUIxRlFaOVJJU2ZDbUlqek5GQit2Nzl3YTdPak9x?=
 =?utf-8?B?MXBDc0lSbXB1VzlxNU1OdWQrYUpNbHVBT2ozeXk2bDRJV0VocytWV25OQVpO?=
 =?utf-8?B?dXBCS0ZFSHV5N0ZsaXNSOXFmMWNsNkZ4Q3EweUJINHZTc1R1b04yMXNzd2ps?=
 =?utf-8?B?a1Z3UTZCUUNsTW4ydTVUN3lNbGIzdDdyUUtPbUo5N2k0WVpSUUpKbzZIcGtC?=
 =?utf-8?B?UUUrRFJ6NHdPSGZTb3dDL2FaNmxlYmYrQTl1M05zTUdpQWpYbGJhbDJhVExF?=
 =?utf-8?B?ZktHSUVuaEtWU1g3UDQwaFRhUHd0M3NWR3Y4akNRdlBtajRwVENEOTFJaURs?=
 =?utf-8?B?K3l5ZW1aNnRad1E2a2JZbXZkVlpXbDNtaWRjckdRd0lLTFJBdnoyU0sxUFJG?=
 =?utf-8?B?cDlsSUFkckh0dDA4bnhkODhoMjZmWnA1cm9yczhhVE83QW1UU2Y3aVBrY09L?=
 =?utf-8?B?Uk1RUGdCdWhXV2Q0bzVCNjdZRXh1N3BZTFNvdXlpOEwxV3pPeDh5MHNKNXpM?=
 =?utf-8?B?cGdoRzgyOFBCWDdtVTJvakNLU2pXTmNURHZPVXQ1ejd3bGsvMWFJd2JTVEpX?=
 =?utf-8?B?R1dMR0t4S2lDalhObEl1RWlaOXBBcWVtQXZWTVpZZFY1cmdhWkkzeFJyRHY2?=
 =?utf-8?B?Mkw4VThCeTEvNTFETFozdkRyNjlaVGIrelNjNkhzSHRaMnN6NEtsOHdZTjhT?=
 =?utf-8?Q?2idXvFm36cDrqGRKABLKS9XSvwzl+UC4qn5qb3I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D165FB47A0FDFA4BAD26A3D68B26416F@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7bdef0-fdc5-45bf-7912-08d9467c362b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 04:02:34.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NHnw8VngZyJHZUd2qr/Hmh+iNxQMJIiAACVvv9Oza6IwA6kPTK/xFi3k120OdD/A72c3HMXzNrEyzhZBNKRNXVMEtLLSocnLhItZc3C3lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3538
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMjAyMS83LzE0LCA2OjE0IEFNLCAiUm9iIEhlcnJpbmciIDxyb2JoQGtlcm5lbC5vcmc+IHdy
b3RlOg0KDQogICAgT24gRnJpLCBKdWwgMDksIDIwMjEgYXQgMDI6NTI6MTZQTSArMDgwMCwgQmls
bHkgVHNhaSB3cm90ZToNCiAgICA+PiBUaGlzIHBhdGNoIGFkZHMgZGV2aWNlIGJpbmRpbmcgZm9y
IGFzcGVlZCBwd20tdGFjaCBkZXZpY2Ugd2hpY2ggaXMgYQ0KICAgID4+IG11bHRpLWZ1bmN0aW9u
IGRldmljZSBpbmNsdWRlIHB3bSBhbmQgdGFjaCBmdW5jdGlvbiBhbmQgcHdtL3RhY2ggZGV2aWNl
DQogICAgPj4gYmluZGluZ3Mgd2hpY2ggc2hvdWxkIGJlIHRoZSBjaGlsZC1ub2RlIG9mIHB3bS10
YWNoIGRldmljZS4NCg0KICAgID5JJ2xsIHNheSBpdCBhZ2FpbiwgdGhlIGZhbiBjb250cm9sIGgv
dyBuZWVkcyBzb21lIGNvbW1vbiBiaW5kaW5ncyBmb3IgDQogICAgPmRlc2NyaWJpbmcgZmFucyBh
bmQgZmFuIGNvbm5lY3Rpb25zIHRvIHB3bSBhbmQgdGFjaC4gSSdtIG5vdCBnb2luZyB0byANCiAg
ICA+c2lnbiBvZmYgb24gbW9yZSBmYW4gYmluZGluZ3MganVzdCBkb2luZyB0aGVpciBvd24gdGhp
bmcuDQoNClRoaXMgcGF0Y2ggZG9lc24ndCB1c2UgdG8gYmluZGluZyB0aGUgZmFuIGNvbnRyb2wg
aC93LiBJdCBpcyB1c2VkIHRvIGJpbmRpbmcgdGhlIHR3byBpbmRlcGVuZGVudCBoL3cgYmxvY2tz
Lg0KT25lIGlzIHVzZWQgdG8gcHJvdmlkZSBwd20gb3V0cHV0IGFuZCBhbm90aGVyIGlzIHVzZWQg
dG8gbW9uaXRvciB0aGUgc3BlZWQgb2YgdGhlIGlucHV0Lg0KSXQgaXMgZGlmZmVyZW50IGZyb20g
ImFzcGVlZC1wd20tdGFjaG8udHh0IiBhbmQgIm5wY203NTAtcHdtLWZhbi50eHQiIHdoaWNoIG9u
bHkgZm9jdXMgb24gZmFuIHVzYWdlLg0KSXQgaXMgbW9yZSBsaWtlIHRoZSAia29udHJvbixzbDI4
Y3BsZC55YW1sIiB0aGUgZGV2aWNlIGluY2x1ZGVzIGEgZmFuIG1vbml0b3IgYW5kIFBXTSBvdXRw
dXQgZGV2aWNlcy4NCg0KICAgID4+IA0KICAgID4+IFNpZ25lZC1vZmYtYnk6IEJpbGx5IFRzYWkg
PGJpbGx5X3RzYWlAYXNwZWVkdGVjaC5jb20+DQogICAgPj4gLS0tDQogICAgPj4gIC4uLi9iaW5k
aW5ncy9od21vbi9hc3BlZWQsYXN0MjYwMC10YWNoLnlhbWwgICB8IDY5ICsrKysrKysrKysrKysr
Kw0KICAgID4+ICAuLi4vYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyNjAwLXB3bS10YWNoLnlhbWwg
fCA4NyArKysrKysrKysrKysrKysrKysrDQogICAgPj4gIC4uLi9iaW5kaW5ncy9wd20vYXNwZWVk
LGFzdDI2MDAtcHdtLnlhbWwgICAgICB8IDY0ICsrKysrKysrKysrKysrDQogICAgPj4gIDMgZmls
ZXMgY2hhbmdlZCwgMjIwIGluc2VydGlvbnMoKykNCiAgICA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hc3BlZWQsYXN0MjYwMC10
YWNoLnlhbWwNCiAgICA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbA0KICAgID4+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9h
c3BlZWQsYXN0MjYwMC1wd20ueWFtbA0KICAgID4+IA0KICAgID4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYXNwZWVkLGFzdDI2MDAtdGFjaC55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FzcGVlZCxhc3Qy
NjAwLXRhY2gueWFtbA0KICAgID4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQogICAgPj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5hMDg0NzFmOTZhNjENCiAgICA+PiAtLS0gL2Rldi9udWxsDQogICAgPj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FzcGVlZCxhc3Qy
NjAwLXRhY2gueWFtbA0KICAgID4+IEBAIC0wLDAgKzEsNjkgQEANCiAgICA+PiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQogICAgPj4g
KyMgQ29weXJpZ2h0IChDKSAyMDIxIEFzcGVlZCwgSW5jLg0KICAgID4+ICslWUFNTCAxLjINCiAg
ICA+PiArLS0tDQogICAgPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaHdt
b24vYXNwZWVkLGFzdDI2MDAtdGFjaC55YW1sIw0KICAgID4+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCiAgICA+PiArDQogICAgPj4gK3Rp
dGxlOiBBc3BlZWQgQXN0MjYwMCBUYWNoIGNvbnRyb2xsZXINCiAgICA+PiArDQogICAgPj4gK21h
aW50YWluZXJzOg0KICAgID4+ICsgIC0gQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNo
LmNvbT4NCiAgICA+PiArDQogICAgPj4gK2Rlc2NyaXB0aW9uOiB8DQogICAgPj4gKyAgVGhlIEFz
cGVlZCBUYWNoIGNvbnRyb2xsZXIgY2FuIHN1cHBvcnQgdXB0byAxNiBmYW4gaW5wdXQuDQogICAg
Pj4gKyAgVGhpcyBtb2R1bGUgaXMgcGFydCBvZiB0aGUgYXN0MjYwMC1wd20tdGFjaCBtdWx0aS1m
dW5jdGlvbiBkZXZpY2UuIEZvciBtb3JlDQogICAgPj4gKyAgZGV0YWlscyBzZWUgLi4vbWZkL2Fz
cGVlZCxhc3QyNjAwLXB3bS10YWNoLnlhbWwuDQogICAgPj4gKw0KICAgID4+ICtwcm9wZXJ0aWVz
Og0KICAgID4+ICsgIGNvbXBhdGlibGU6DQogICAgPj4gKyAgICBlbnVtOg0KICAgID4+ICsgICAg
ICAtIGFzcGVlZCxhc3QyNjAwLXRhY2gNCiAgICA+PiArDQogICAgPj4gKyAgIiNhZGRyZXNzLWNl
bGxzIjoNCiAgICA+PiArICAgIGNvbnN0OiAxDQogICAgPj4gKw0KICAgID4+ICsgICIjc2l6ZS1j
ZWxscyI6DQogICAgPj4gKyAgICBjb25zdDogMA0KICAgID4+ICsNCiAgICA+PiArICBwaW5jdHJs
LTA6IHRydWUNCiAgICA+PiArDQogICAgPj4gKyAgcGluY3RybC1uYW1lczoNCiAgICA+PiArICAg
IGNvbnN0OiBkZWZhdWx0DQogICAgPj4gKw0KICAgID4+ICtyZXF1aXJlZDoNCiAgICA+PiArICAt
IGNvbXBhdGlibGUNCiAgICA+PiArICAtICIjYWRkcmVzcy1jZWxscyINCiAgICA+PiArICAtICIj
c2l6ZS1jZWxscyINCiAgICA+PiArDQogICAgPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOg0KICAg
ID4+ICsgIHR5cGU6IG9iamVjdA0KICAgID4+ICsgIHByb3BlcnRpZXM6DQogICAgPj4gKyAgICBy
ZWc6DQogICAgPj4gKyAgICAgIGRlc2NyaXB0aW9uOg0KICAgID4+ICsgICAgICAgIFRoZSB0YWNo
IGNoYW5uZWwgdXNlZCBmb3IgdGhpcyBmYW4uDQogICAgPj4gKyAgICAgIG1heEl0ZW1zOiAxDQog
ICAgPj4gKw0KICAgID4+ICsgICAgYXNwZWVkLG1pbi1ycG06DQogICAgPj4gKyAgICAgIGRlc2Ny
aXB0aW9uOg0KICAgID4+ICsgICAgICAgIGRlZmluZSB0aGUgbWluaW1hbCByZXZvbHV0aW9ucyBw
ZXIgbWludXRlIG9mIHRoZSBtZWFzdXJlIGZhbg0KICAgID4+ICsgICAgICAgIHVzZWQgdG8gY2Fs
Y3VsYXRlIHRoZSBzYW1wbGUgcGVyaW9kIG9mIHRhY2gNCiAgICA+PiArICAgICAgZGVmYXVsdDog
MTAwMA0KICAgID4+ICsNCiAgICA+PiArICAgIGFzcGVlZCxwdWxzZS1wcjoNCiAgICA+PiArICAg
ICAgZGVzY3JpcHRpb246DQogICAgPj4gKyAgICAgICAgVmFsdWUgc3BlY2lmeWluZyB0aGUgbnVt
YmVyIG9mIHB1bHNlcyBwZXIgcmV2b2x1dGlvbiBvZiB0aGUNCiAgICA+PiArICAgICAgICBtb25p
dG9yZWQgRkFOLg0KICAgID4+ICsgICAgICBkZWZhdWx0OiAyDQogICAgPj4gKw0KICAgID4+ICsg
ICAgYXNwZWVkLHRhY2gtZGl2Og0KICAgID4+ICsgICAgICBkZXNjcmlwdGlvbjoNCiAgICA+PiAr
ICAgICAgICBkZWZpbmUgdGhlIHRhY2hvbWV0ZXIgY2xvY2sgZGl2aWRlciBhcyBhbiBpbnRlZ2Vy
LiBGb3JtdWxhIG9mDQogICAgPj4gKyAgICAgICAgdGFjaCBjbG9jayA9IGNsb2NrIHNvdXJjZSAv
ICgyXnRhY2gtZGl2KV4yDQogICAgPj4gKyAgICAgIG1pbmltdW06IDANCiAgICA+PiArICAgICAg
bWF4aW11bTogMTUNCiAgICA+PiArICAgICAgIyBUaGUgdmFsdWUgdGhhdCBzaG91bGQgYmUgdXNl
ZCBpZiB0aGUgcHJvcGVydHkgaXMgbm90IHByZXNlbnQNCiAgICA+PiArICAgICAgZGVmYXVsdDog
NQ0KICAgID4+ICsNCiAgICA+PiArICByZXF1aXJlZDoNCiAgICA+PiArICAgIC0gcmVnDQogICAg
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNw
ZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbA0KICAgID4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQogICAgPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5hYjQ5YWZmMTkyOGENCiAgICA+
PiAtLS0gL2Rldi9udWxsDQogICAgPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9hc3BlZWQsYXN0MjYwMC1wd20tdGFjaC55YW1sDQogICAgPj4gQEAgLTAsMCAr
MSw4NyBAQA0KICAgID4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5
IE9SIEJTRC0yLUNsYXVzZSkNCiAgICA+PiArIyBDb3B5cmlnaHQgKEMpIDIwMjEgQXNwZWVkLCBJ
bmMuDQogICAgPj4gKyVZQU1MIDEuMg0KICAgID4+ICstLS0NCiAgICA+PiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbCMN
CiAgICA+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjDQogICAgPj4gKw0KICAgID4+ICt0aXRsZTogUFdNIFRhY2ggY29udHJvbGxlciBEZXZp
Y2UgVHJlZSBCaW5kaW5ncw0KICAgID4+ICsNCiAgICA+PiArZGVzY3JpcHRpb246IHwNCiAgICA+
PiArICBUaGUgUFdNIFRhY2ggY29udHJvbGxlciBpcyByZXByZXNlbnRlZCBhcyBhIG11bHRpLWZ1
bmN0aW9uIGRldmljZSB3aGljaA0KICAgID4+ICsgIGluY2x1ZGVzOg0KICAgID4+ICsgICAgUFdN
DQogICAgPj4gKyAgICBUYWNoDQogICAgPj4gKw0KICAgID4+ICttYWludGFpbmVyczoNCiAgICA+
PiArICAtIEJpbGx5IFRzYWkgPGJpbGx5X3RzYWlAYXNwZWVkdGVjaC5jb20+DQogICAgPj4gKw0K
ICAgID4+ICtwcm9wZXJ0aWVzOg0KICAgID4+ICsgIGNvbXBhdGlibGU6DQogICAgPj4gKyAgICBp
dGVtczoNCiAgICA+PiArICAgICAgLSBlbnVtOg0KICAgID4+ICsgICAgICAgICAgLSBhc3BlZWQs
YXN0MjYwMC1wd20tdGFjaA0KICAgID4+ICsgICAgICAtIGNvbnN0OiBzeXNjb24NCiAgICA+PiAr
ICAgICAgLSBjb25zdDogc2ltcGxlLW1mZA0KICAgID4+ICsNCiAgICA+PiArICByZWc6DQogICAg
Pj4gKyAgICBtYXhJdGVtczogMQ0KICAgID4+ICsNCiAgICA+PiArICBjbG9ja3M6DQogICAgPj4g
KyAgICBtYXhJdGVtczogMQ0KICAgID4+ICsNCiAgICA+PiArICByZXNldHM6DQogICAgPj4gKyAg
ICBtYXhJdGVtczogMQ0KICAgID4+ICsNCiAgICA+PiArcmVxdWlyZWQ6DQogICAgPj4gKyAgLSBj
b21wYXRpYmxlDQogICAgPj4gKyAgLSByZWcNCiAgICA+PiArICAtIGNsb2Nrcw0KICAgID4+ICsg
IC0gcmVzZXRzDQogICAgPj4gKw0KICAgID4+ICtwYXR0ZXJuUHJvcGVydGllczoNCiAgICA+PiAr
ICAiXnB3bShAWzAtOWEtZl0rKT8kIjoNCiAgICA+PiArICAgICRyZWY6IC4uL3B3bS9hc3BlZWQs
YXN0MjYwMC1wd20ueWFtbA0KICAgID4+ICsNCiAgICA+PiArICAiXnRhY2goQFswLTlhLWZdKyk/
JCI6DQogICAgPj4gKyAgICAkcmVmOiAuLi9od21vbi9hc3BlZWQsYXN0MjYwMC10YWNoLnlhbWwN
CiAgICA+PiArDQogICAgPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KICAgID4+ICsN
CiAgICA+PiArZXhhbXBsZXM6DQogICAgPj4gKyAgLSB8DQogICAgPj4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvY2xvY2svYXN0MjYwMC1jbG9jay5oPg0KICAgID4+ICsgICAgcHdtX3RhY2g6
IHB3bV90YWNoQDFlNjEwMDAwIHsNCiAgICA+PiArICAgICAgY29tcGF0aWJsZSA9ICJhc3BlZWQs
YXN0MjYwMC1wd20tdGFjaCIsICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQogICAgPj4gKyAgICAg
IHJlZyA9IDwweDFlNjEwMDAwIDB4MTAwPjsNCiAgICA+PiArICAgICAgY2xvY2tzID0gPCZzeXNj
b24gQVNQRUVEX0NMS19BSEI+Ow0KICAgID4+ICsgICAgICByZXNldHMgPSA8JnN5c2NvbiBBU1BF
RURfUkVTRVRfUFdNPjsNCiAgICA+PiArDQogICAgPj4gKyAgICAgIHB3bTogcHdtIHsNCiAgICA+
PiArICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNjAwLXB3bSI7DQogICAgPj4gKyAg
ICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogICAgPj4gKyAgICAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQogICAgPj4gKyAgICAgICAgI3B3bS1jZWxscyA9IDwzPjsNCiAgICA+PiArICAgICAg
ICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgID4+ICsgICAgICAgIHBpbmN0cmwtMCA9
IDwmcGluY3RybF9wd20wX2RlZmF1bHQ+Ow0KICAgID4+ICsgICAgICAgIHB3bS1jaEAwIHsNCiAg
ICA+PiArICAgICAgICAgIHJlZyA9IDwwPjsNCiAgICA+PiArICAgICAgICAgIGFzcGVlZCx3ZHQt
cmVsb2FkLWVuYWJsZTsNCiAgICA+PiArICAgICAgICAgIGFzcGVlZCx3ZHQtcmVsb2FkLWR1dHkt
cG9pbnQgPSA8MzI+Ow0KICAgID4+ICsgICAgICAgIH07DQogICAgPj4gKyAgICAgIH07DQogICAg
Pj4gKw0KICAgID4+ICsgICAgICB0YWNoOiB0YWNoIHsNCiAgICA+PiArICAgICAgICBjb21wYXRp
YmxlID0gImFzcGVlZCxhc3QyNjAwLXRhY2giOw0KICAgID4+ICsgICAgICAgICNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KICAgID4+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KICAgID4+ICsg
ICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgPj4gKyAgICAgICAgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX3RhY2gwX2RlZmF1bHQ+Ow0KICAgID4+ICsgICAgICAgIHRhY2gtY2hA
MCB7DQogICAgPj4gKyAgICAgICAgICByZWcgPSA8MD47DQogICAgPj4gKyAgICAgICAgICBhc3Bl
ZWQsbWluLXJwbSA9IDwxMDAwPjsNCiAgICA+PiArICAgICAgICAgIGFzcGVlZCxwdWxzZS1wciA9
IDwyPjsNCiAgICA+PiArICAgICAgICAgIGFzcGVlZCx0YWNoLWRpdiA9IDw1PjsNCiAgICA+PiAr
ICAgICAgICB9Ow0KICAgID4+ICsgICAgICB9Ow0KICAgID4+ICsgICAgfTsNCiAgICA+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hc3BlZWQsYXN0
MjYwMC1wd20ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXNw
ZWVkLGFzdDI2MDAtcHdtLnlhbWwNCiAgICA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KICAgID4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uZjUwMWY4YTc2OWRmDQogICAgPj4gLS0tIC9kZXYvbnVsbA0K
ICAgID4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXNwZWVk
LGFzdDI2MDAtcHdtLnlhbWwNCiAgICA+PiBAQCAtMCwwICsxLDY0IEBADQogICAgPj4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KICAg
ID4+ICsjIENvcHlyaWdodCAoQykgMjAyMSBBc3BlZWQsIEluYy4NCiAgICA+PiArJVlBTUwgMS4y
DQogICAgPj4gKy0tLQ0KICAgID4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L3B3bS9hc3BlZWQsYXN0MjYwMC1wd20ueWFtbCMNCiAgICA+PiArJHNjaGVtYTogaHR0cDovL2Rl
dmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQogICAgPj4gKw0KICAgID4+ICt0
aXRsZTogQXNwZWVkIEFzdDI2MDAgUFdNIGNvbnRyb2xsZXINCiAgICA+PiArDQogICAgPj4gK21h
aW50YWluZXJzOg0KICAgID4+ICsgIC0gQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNo
LmNvbT4NCiAgICA+PiArDQogICAgPj4gK2Rlc2NyaXB0aW9uOiB8DQogICAgPj4gKyAgVGhlIEFz
cGVlZCBQV00gY29udHJvbGxlciBjYW4gc3VwcG9ydCB1cHRvIDE2IFBXTSBvdXRwdXRzLg0KICAg
ID4+ICsgIFRoaXMgbW9kdWxlIGlzIHBhcnQgb2YgdGhlIGFzdDI2MDAtcHdtLXRhY2ggbXVsdGkt
ZnVuY3Rpb24gZGV2aWNlLiBGb3IgbW9yZQ0KICAgID4+ICsgIGRldGFpbHMgc2VlIC4uL21mZC9h
c3BlZWQsYXN0MjYwMC1wd20tdGFjaC55YW1sLg0KICAgID4+ICsNCiAgICA+PiArcHJvcGVydGll
czoNCiAgICA+PiArICBjb21wYXRpYmxlOg0KICAgID4+ICsgICAgZW51bToNCiAgICA+PiArICAg
ICAgLSBhc3BlZWQsYXN0MjYwMC1wd20NCiAgICA+PiArDQogICAgPj4gKyAgIiNwd20tY2VsbHMi
Og0KICAgID4+ICsgICAgY29uc3Q6IDMNCiAgICA+PiArDQogICAgPj4gKyAgIiNhZGRyZXNzLWNl
bGxzIjoNCiAgICA+PiArICAgIGNvbnN0OiAxDQogICAgPj4gKw0KICAgID4+ICsgICIjc2l6ZS1j
ZWxscyI6DQogICAgPj4gKyAgICBjb25zdDogMA0KICAgID4+ICsNCiAgICA+PiArICBwaW5jdHJs
LTA6IHRydWUNCiAgICA+PiArDQogICAgPj4gKyAgcGluY3RybC1uYW1lczoNCiAgICA+PiArICAg
IGNvbnN0OiBkZWZhdWx0DQogICAgPj4gKw0KICAgID4+ICtyZXF1aXJlZDoNCiAgICA+PiArICAt
IGNvbXBhdGlibGUNCiAgICA+PiArICAtICIjcHdtLWNlbGxzIg0KICAgID4+ICsgIC0gIiNhZGRy
ZXNzLWNlbGxzIg0KICAgID4+ICsgIC0gIiNzaXplLWNlbGxzIg0KICAgID4+ICsNCiAgICA+PiAr
YWRkaXRpb25hbFByb3BlcnRpZXM6DQogICAgPj4gKyAgZGVzY3JpcHRpb246IFNldCBleHRlbmQg
cHJvcGVydGllcyBmb3IgZWFjaCBwd20gY2hhbm5lbC4NCiAgICA+PiArICB0eXBlOiBvYmplY3QN
CiAgICA+PiArICBwcm9wZXJ0aWVzOg0KICAgID4+ICsgICAgcmVnOg0KICAgID4+ICsgICAgICBk
ZXNjcmlwdGlvbjoNCiAgICA+PiArICAgICAgICBUaGUgcHdtIGNoYW5uZWwgaW5kZXguDQogICAg
Pj4gKyAgICAgIG1heEl0ZW1zOiAxDQogICAgPj4gKw0KICAgID4+ICsgICAgYXNwZWVkLHdkdC1y
ZWxvYWQtZW5hYmxlOg0KICAgID4+ICsgICAgICB0eXBlOiBib29sZWFuDQogICAgPj4gKyAgICAg
IGRlc2NyaXB0aW9uOg0KICAgID4+ICsgICAgICAgIEVuYWJsZSB0aGUgZnVuY3Rpb24gb2Ygd2R0
IHJlc2V0IHJlbG9hZCBkdXR5IHBvaW50Lg0KICAgID4+ICsNCiAgICA+PiArICAgIGFzcGVlZCx3
ZHQtcmVsb2FkLWR1dHktcG9pbnQ6DQogICAgPj4gKyAgICAgIGRlc2NyaXB0aW9uOg0KICAgID4+
ICsgICAgICAgIERlZmluZSB0aGUgZHV0eSBwb2ludCBhZnRlciB3ZHQgcmVzZXQsIDAgPSAxMDAl
DQogICAgPj4gKyAgICAgIG1pbmltdW06IDANCiAgICA+PiArICAgICAgbWF4aW11bTogMjU1DQog
ICAgPj4gKw0KICAgID4+ICsgIHJlcXVpcmVkOg0KICAgID4+ICsgICAgLSByZWcNCiAgICA+PiAt
LSANCiAgICA+PiAyLjI1LjENCiAgICA+PiANCiAgICA+Pg0KDQo=
