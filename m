Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502C5EFC86
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiI2R7H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiI2R7E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 13:59:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF691DB6;
        Thu, 29 Sep 2022 10:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQen0VJUFsNVtRNoPWCJFzWnnX5P49nbDP0XIkTZZXeN8RKRy4XcFAb+P3iDkmtFPGoJyWK5zukR9S3Nfizt2HmSDb6eNp2cnmpoWk7DlZ8JQq3QzeeD5TPfO5Tm06SDtEWQ+yXptTxT8zboZbu8uHbNCt73ADId38xInIhzsYbxTPRxx8fXJrmsOjcnJVso6hnxJUHXEWOh+IEnEj9uKd3V46mHJGkW+DfgTa3XKHsXIbkxkh9//JLrvruJdKOBnb0XBL8gtaZpxmcwAIkAcdfSNQh7IVPRwfqingPAtbLFRzywjC91pK4muiTzseeIg4/k1cSvld4letOhJFuGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDoTZgFVeSYhTdDcmxRnwKtjEehsV3rLnSx3Yq/+lIw=;
 b=hte6YBfQiFSvMnx1vtA9DLjWgdTdh5fIkIv/mMgxa7D1+I7T38NVHIvqP5n3G0j+CF+pVMaOzAgkc4GBT7SByl/mN/oI6XgUt7xzaEDIMGw2UBjC8Q6ufQRPC2Q3mEzXBR3w38UmyuhjI4F+1yKnbbXcHIjKzWofCY7wpj2VdtxcRKf4xN0NhLwO7oI3PCkkre5+lDEh+YUEBFbmxE9ezJe2NYlStrqggGROL9rT2hGXnq9rIY+zLmeA6ykWN5w+R3qb9ELtygdVDtzw4ZWHeO1661ZMuT7JnafNhKMtPrF4oYLWOD20cj4Gn7ELTVXvncdHbHYh8hRDidipPIAAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDoTZgFVeSYhTdDcmxRnwKtjEehsV3rLnSx3Yq/+lIw=;
 b=UFJiQtftOolZb/3hKRNQd6wehuquNNKDvWHd+etcY3734DmUWJa1p90lPrzuHoKhvtDrY8PwF2Bl4VYrCVJgZO0aor5lkMXZH90GByopAFZY7xKQLn4UwFyQIZVB5kZYs/Rv+QbhCFn4MDJflbzc9T2uxepEtGIY3yRpHvjSCpw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5964.jpnprd01.prod.outlook.com (2603:1096:402:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 17:59:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 17:59:01 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Topic: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Index: AQHY0+6TADmAt9m0c0u1ieTfUadBoq32sJKAgAABH3A=
Date:   Thu, 29 Sep 2022 17:59:01 +0000
Message-ID: <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
In-Reply-To: <YzXbU69imBM5aKwn@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5964:EE_
x-ms-office365-filtering-correlation-id: d66e0c02-83a5-4eae-e9d7-08daa2444a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fY90sY0vheveep3pDgGFSgUMATiq5GqI/PnftQk9C2XntuKhdrzmm4PfYmdTf0c+etsOXH4N0pIzj47tDgSsY0HwrRDVxrMg4sqJO5Eh96yseNRF7qiepNTq+iinjVJTGj7SLIvMqpnYilh46pCVZkKJIqYPKWxR3D4zdWPso7PGjIlcDaUPnUZ3SBo9zO0xhvXT3BW+ac6i8wLqJNVA4OSKPSAtOzV9uehfD4TcihDRB7kJtI5eZ7Psyf8oIy0rGAaL85ReeKibOBgdYhsGWhXk7Qju6OqtZKCV3SE4CkMnSX4fz98sIZNj08OZdO3k/5meoNAKEzzv5DarlC1M3BbAlEVbN2aWYwrokJA07QwA319caHy1fxLHqA4/v3SqCa4fbrQhS+K7MQu1llI7qB0ci8N/VCHdPOlmXjUsUtZY8msbD4KLo5f/LXv+zfyYdCW0lO9nR+eK/bu2pigwwuvD9hxJ5eSvhBXznHbJJuqUVf3z84eek0GuoEqfipp5UOnlXHf9qTK6F23L3mPTbfeyEV8BZKhkvP4yuG+SDnVaSgBWu/Wk4RYV2rNhSXDWNzeChtF/Gi7RwqvGHrXo5MXQAsBX9dF3eHB2RKtvD7CpsdCJQCoY+QfdQIk4kXSBwUj7L6OJjVksGqLown6nzcw1w/O/zUGulvsxK1S4oZfY3mowpalv6uuoYGGhSVXt04/jIM0q+3VEe18ycfRAwu6MNpXkIOxDkuu0dFw7QqQMrRo0Rrr/OSBtiM8cJri6n9XPOMsUNBP5BC1sCkpEYG28tdGBJ3wFi4Nxkw3uP7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(38100700002)(186003)(9686003)(38070700005)(8936002)(122000001)(5660300002)(26005)(41300700001)(2906002)(55016003)(966005)(71200400001)(478600001)(7696005)(6506007)(8676002)(64756008)(66556008)(66946007)(4326008)(52536014)(66476007)(66446008)(76116006)(6916009)(316002)(33656002)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2NXV3BLMG5ESFZuL1Fqckltd1lkd2VZc2NucS8yMGtqUWVpVExUZGUwbU1p?=
 =?utf-8?B?eGIxUmNZTXlsc2N5Q01qZTRqaFI2eGNVWmNTYnFuelBQN2l2K05yLzB0czFr?=
 =?utf-8?B?S0tVMitHUWk4V0h5RlkwWUxyUGVubnhmZmpMaENERWNZNlBkNFgvUExLUGhP?=
 =?utf-8?B?MmNBL0NUMWxEd0hvSmpPNHhINVpmUnFxV1o0WTNNY2Ewa21HYmVva1BZN3Yx?=
 =?utf-8?B?d0h5YkpsRlZnWitPN1ozMkFqVE5uQy8yUXdIVUtVTWxYcmhIaS9IenIrMHRP?=
 =?utf-8?B?UG1OY0J0NHlsWmJGcnBudm9DdDJxUlAyTVNILzVna1dwckxYaGdvZ3Q3VCt3?=
 =?utf-8?B?SVpBNGRaZk9ZRmx2VkFQS3dXOWRic2hXdTBRcmZGd3dUcEZYS3FnQ2U0WTd1?=
 =?utf-8?B?ME1tUzNsVUw5NW9uR0ZRU0UwaE8xQmpHc2NLdXhlOVdYYWU0WmNJbEZUNWdB?=
 =?utf-8?B?U3ZGaFM3YWZUN3FzLzdGRjN5blpIc253ck02NXFtRVRmNXFmU0NnMVo5eFI4?=
 =?utf-8?B?TG9hSWRJWi9aUSs5VGhBYXAwaHpjejV3WEgxM1k4QUY2ZHpJdE9rN2UxOFZV?=
 =?utf-8?B?YjhlbnN2ZzJPSGFJYTJEME5MQUIrMWxSRzZsY3V2Qzh4RWtVckF6RWhaK1Nq?=
 =?utf-8?B?VjVDWXBSMTJSczk5VFNmMnBXUGFRWUZydk5hb2Jsb2huTFhPOTl2ZHl4Z1Fu?=
 =?utf-8?B?WVFFY0JuSFc5cGgwNGxBbG5LZ3hMNFZ3Yy9rNkZMbldad3ErUGExT1RqT2dq?=
 =?utf-8?B?TVM1VE5IcExpMnZDY25oSWRFaTNSMGNVRjJkNlBXeEs1ZHF5ODdDV05xQlI3?=
 =?utf-8?B?dWVQSzdsSWNCSk0xbFhENlZkUk40V2pTZmYxU1BFTWF6OUlXUGJDUGtKK1hZ?=
 =?utf-8?B?L3pZVm5GTm42Yk0xeHpIZENLVE94SWxaemFTUUVJRDI2Qk9xNUJIZkZ3cCt0?=
 =?utf-8?B?MXBUbUlOcW9LdnlmUFdqZUxVbnRqazExc3hWNTMzWFpYL3dZTFlHOUxzaDBH?=
 =?utf-8?B?L0RNNUtGb20rT3NxWHluYXN5eTJLTGRSRE9rcUZXTDFPcUFZUnh4RzJpaCtD?=
 =?utf-8?B?dHcreVNYSkx0ZnFMWEltSGRUd1B1MnIxZjdpeG8vRHhQT3MycVdMVEMyVGc3?=
 =?utf-8?B?UWljM0xmeGNrZlAxeUlhbndIUGVNZTF2M2t5R3N4QmE0dWFPNGVmUjErU2xB?=
 =?utf-8?B?aWZhTWEvU0M3eEQ5d1ZkWTVHR1dJWVE3ZVJ1Z3JWdTZLdWo4dU1DendOcTVr?=
 =?utf-8?B?SXJsdTAyZndGUWRzNFhwUVJOa05TWWcxVkczcU10NEZLb294TnBYdmt1ZEdw?=
 =?utf-8?B?SzVEcHNuWGpSYUJCd0dkQmFDOVQzS25EN0FmMy9pc3FWZmo2azRtdEM1VFRy?=
 =?utf-8?B?S25PR2kyeE4rMDJ2Z056MU12NXRPVlpCMEZkSzAzTEpMZEtqZmNLTTltSDlK?=
 =?utf-8?B?RDY2SmR3K2NGT05RSEpiTWxxck1KRU04czczakhLZUgrYTlxOXVtODZpNC80?=
 =?utf-8?B?ZUdGNFEzTFBPejRPTEhlWkpvWkpoUExpMUg0YTlnQlBvOXphQnFCdmx0eDNi?=
 =?utf-8?B?bHRLZlMxeHRZa1VzYUwzNFN5dTE1M3dERWw3cXpaTEJFcnNIMHZPcVlraGEy?=
 =?utf-8?B?blFHNFkySnJKbGM0YUR1bmJnTTFKRSsrM2J1MHV2MkFUSGNCVGdRSXdpZ2xh?=
 =?utf-8?B?QUNYSVl4YXNqaWhvN0lsTVBaUDJxMzVCbmc1bGNaY3dYdlNOVnpQNGVrNlRQ?=
 =?utf-8?B?bEdYUXNGVkZWLzRVWXF3NTI0NjQvYmxwOUQ4MkRjWmpqMWp0VjI0K0djZlpJ?=
 =?utf-8?B?bXg3bnEramFLSU0wVUszQXM5Ykk5OVNKaXFBdG9sSXl2dEFrZ3dyb1BER3V1?=
 =?utf-8?B?YVVCMHNZNFkramZydXZyMUF0UnhHT1BlS09Bb1YwbDhKVEprQnJPMmp0WHJs?=
 =?utf-8?B?QXpYUDE3aEpzRHUrOUNSVmRyK3NrSndHYjRYYVY1NFhuelVCc0w0RHRsVWx4?=
 =?utf-8?B?R0tmbHZ2NEFtUFdtMzN0bjFINStxZkV3QXpTWkJnblJQODdOY1VlUEtkeFJW?=
 =?utf-8?B?UDJsMS9ERkdwMHVhdUYvbFBQZDlVbU1Cd1RkQmdDdjcvalozVSs3SXV1MEdN?=
 =?utf-8?B?Sk1WaDFONkd0aWlYS3V5MHhScmZLOFFkWHlmZEd2d25jb2pHQ0J6NCt4VTZ6?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66e0c02-83a5-4eae-e9d7-08daa2444a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 17:59:01.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lZIGd6UIFEehhl02kNozo43ATyxIsnomoEqNAABOe3tWQBwt7vhKFr9/Cvz3tihna8BCCZnngwK+XI6e9Qq+sfh66xa2FMIkC5lwJGiCYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5964
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGVlIEpvbmVzLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRpbmdzOiBtZmQ6IHJ6LW10dTM6IERvY3VtZW50DQo+
IFJaL0cyTCBNVFUzIFBXTQ0KPiANCj4gT24gVGh1LCAyOSBTZXAgMjAyMiwgQmlqdSBEYXMgd3Jv
dGU6DQo+IA0KPiA+IERvY3VtZW50IFJaL0cyTCBNVFUzIFBXTSBzdXBwb3J0LiBJdCBzdXBwb3J0
cyBmb2xsb3dpbmcgcHdtIG1vZGVzLg0KPiA+IAkxKSBQV00gbW9kZSAxDQo+ID4gCTIpIFBXTSBt
b2RlIDINCj4gPiAJMykgUmVzZXQtc3luY2hyb25pemVkIFBXTSBtb2RlDQo+ID4gCTQpIENvbXBs
ZW1lbnRhcnkgUFdNIG1vZGUgMSAodHJhbnNmZXIgYXQgY3Jlc3QpDQo+ID4gCTUpIENvbXBsZW1l
bnRhcnkgUFdNIG1vZGUgMiAodHJhbnNmZXIgYXQgdHJvdWdoKQ0KPiA+IAk2KSBDb21wbGVtZW50
YXJ5IFBXTSBtb2RlIDMgKHRyYW5zZmVyIGF0IGNyZXN0IGFuZCB0cm91Z2gpDQo+IA0KPiBTaG91
bGRuJ3QgYWxsIHRoaXMgZ28gaW4gdGhlIFBXTSBkcml2ZXIgYmluZGluZz8NCg0KTG9va3MgbGlr
ZSBhdCB0b3AgbGV2ZWwgTVRVMyBJUCBwcm92aWRlcyBzaW1pbGFyIEhXIGZ1bmN0aW9uYWxpdHkg
bGlrZSBiZWxvdw0KYmluZGluZyBbMV0sIHdoZXJlIHRoZXJlIGlzIGEgY29yZSBNRkQgZHJpdmVy
IGFuZCBwd20sIGNvdW50ZXIgYW5kIHRpbWVyDQphcyBjaGlsZCBkZXZpY2VzLg0KDQpbMV0gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1yYzcvc291cmNlL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3Qsc3RtMzItdGltZXJzLnlhbWwNCg0KQ2hlZXJz
LA0KQmlqdQ0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tZmQvcmVuZXNhcyxyemcy
bC1tdHUzLnlhbWwgICAgICB8IDUwDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JlbmVzYXMscnpnMmwtDQo+IG10dTMueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcmVuZXNhcyxyemcybC0N
Cj4gbXR1My55YW1sDQo+ID4gaW5kZXggYzRiY2YyODYyM2Q2Li4zNjJmZWRmNWJlZGIgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yZW5lc2Fz
LHJ6ZzJsLW10dTMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQvcmVuZXNhcyxyemcybC1tdHUzLnlhbWwNCj4gPiBAQCAtMjIzLDYgKzIyMyw1MCBA
QCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICAgICAgLSBjb21wYXRpYmxlDQo+ID4gICAgICAg
IC0gcmVnDQo+ID4NCj4gPiArICAiXnB3bUAoWzAtNF18WzYtN10pKyQiOg0KPiA+ICsgICAgdHlw
ZTogb2JqZWN0DQo+ID4gKw0KPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgY29tcGF0
aWJsZToNCj4gPiArICAgICAgICBjb25zdDogcmVuZXNhcyxyei1tdHUzLXB3bQ0KPiA+ICsNCj4g
PiArICAgICAgcmVnOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBJZGVudGlmeSBwd20gY2hh
bm5lbHMuDQo+ID4gKyAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICBlbnVtOiBbIDAsIDEs
IDIsIDMsIDQsIDYsIDcgXQ0KPiA+ICsNCj4gPiArICAgICAgIiNwd20tY2VsbHMiOg0KPiA+ICsg
ICAgICAgIGNvbnN0OiAyDQo+ID4gKw0KPiA+ICsgICAgICByZW5lc2FzLHB3bS1tb2RlMToNCj4g
PiArICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IEVuYWJs
ZSBQV00gbW9kZSAxLg0KPiA+ICsNCj4gPiArICAgICAgcmVuZXNhcyxwd20tbW9kZTI6DQo+ID4g
KyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBFbmFibGUg
UFdNIG1vZGUgMi4NCj4gPiArDQo+ID4gKyAgICAgIHJlbmVzYXMscmVzZXQtc3luY2hyb25pemVk
LXB3bS1tb2RlOg0KPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgICAgICBkZXNj
cmlwdGlvbjogRW5hYmxlIFJlc2V0LXN5bmNocm9uaXplZCBQV00gbW9kZS4NCj4gPiArDQo+ID4g
KyAgICAgIHJlbmVzYXMsY29tcGxlbWVudGFyeS1wd20tbW9kZTE6DQo+ID4gKyAgICAgICAgdHlw
ZTogYm9vbGVhbg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBDb21wbGVtZW50YXJ5IFBXTSBt
b2RlIDEgKHRyYW5zZmVyIGF0IGNyZXN0KS4NCj4gPiArDQo+ID4gKyAgICAgIHJlbmVzYXMsY29t
cGxlbWVudGFyeS1wd20tbW9kZTI6DQo+ID4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsg
ICAgICAgIGRlc2NyaXB0aW9uOiBDb21wbGVtZW50YXJ5IFBXTSBtb2RlIDIgKHRyYW5zZmVyIGF0
IHRyb3VnaCkuDQo+ID4gKw0KPiA+ICsgICAgICByZW5lc2FzLGNvbXBsZW1lbnRhcnktcHdtLW1v
ZGUzOg0KPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgICAgICBkZXNjcmlwdGlv
bjogQ29tcGxlbWVudGFyeSBQV00gbW9kZSAzICh0cmFuc2ZlciBhdCBjcmVzdA0KPiBhbmQgdHJv
dWdoKS4NCj4gPiArDQo+ID4gKyAgICByZXF1aXJlZDoNCj4gPiArICAgICAgLSBjb21wYXRpYmxl
DQo+ID4gKyAgICAgIC0gcmVnDQo+ID4gKyAgICAgIC0gIiNwd20tY2VsbHMiDQo+ID4gKw0KPiA+
ICByZXF1aXJlZDoNCj4gPiAgICAtIGNvbXBhdGlibGUNCj4gPiAgICAtIHJlZw0KPiA+IEBAIC0z
MDUsNiArMzQ5LDEyIEBAIGV4YW1wbGVzOg0KPiA+ICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVu
ZXNhcyxyemcybC1tdHUzLWNvdW50ZXIiOw0KPiA+ICAgICAgICAgIHJlZyA9IDwxPjsNCj4gPiAg
ICAgICAgfTsNCj4gPiArICAgICAgcHdtQDMgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
cmVuZXNhcyxyei1tdHUzLXB3bSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDM+Ow0KPiA+ICsgICAg
ICAgICNwd20tY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgcmVuZXNhcyxwd20tbW9kZTE7DQo+
ID4gKyAgICAgIH07DQo+ID4gICAgICB9Ow0KPiA+DQo+ID4gIC4uLg0KPiANCj4gLS0NCj4gTGVl
IEpvbmVzIFvmnY7nkLzmlq9dDQo=
