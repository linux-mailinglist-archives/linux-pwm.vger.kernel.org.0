Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB05FFB86
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Oct 2022 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJORbp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Oct 2022 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJORbl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Oct 2022 13:31:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99E3FEDD;
        Sat, 15 Oct 2022 10:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHwrFP4UrkBrMHB68kYK5sBiykndga84qpvo1Ufi8BLMSYlseN1oykZF/rvsAByp5IBQBLaknzyenm9Og3wPopfbhSMlQzYAkoQl7Uy8FF7p4xkfT5OAo+o+GeCR2phbYEhB/THwuIQn2N7AbqPn1+bKrlUjrDCkttJcxUDPgOTNk/f8ZoZKN3+fiRudSe+mGSZNVSzXHraS9h/rxFR2Aa8WJDP8/E6nRRm91iSU7MhtJwgTB6+VPp0jdbahIy/DtIg6JGUT/GY49KolxlbgM0Ept7Y8L4UMTipwtOb/5lraSnfkfyLociBGyuVRaS5jy+EnO1DOYeFYhGCeUXjpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWaui0UnTcXjz08aKy/es3VBa+IxhHSbrOEpI/75eWY=;
 b=gDIh32C0oG45C94LPDyM7Tf4OqTpFV9l1vwqMIWhjoW+XIX+n/1kaNnYpaJr+irxHkpMsOyOTYYEisjJ0+D0Ms/FNzkIu6DzmHiCeUt2i4bdDHpO4c8IjkO2Gz+LsFSilQZf9LSQBjgIuVRT2uGkVUehekle19cy9IOXSxk7Gip73vKLvKwaD/59jtbgzNuRP7scqvwBcJw1IqUZgfyt+OIOid4NwYjFdLGjbcg+RXru1dQU6ex9+5Rq7NUPwwEdhgIhJELbWzThqTwpF2utja4wQu4z0dRjsWijwAAWYrWfdE48Qmxkm/UQ//ILok2LeNgtGzdOTDZ3+fTAiLCAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWaui0UnTcXjz08aKy/es3VBa+IxhHSbrOEpI/75eWY=;
 b=ktjB2I8TjdxNfFD4+9nVFNWPfgahjDYvaw0mDtO7hIujO4umZb2CsQFoWVAPpUKnwd0uDVvG15hui/Ufe8+rQVMH0PVcqU+Ka7sGEbpSeXUE5CrMjEs9o0daQuI5oQWu/ij7kiJuQf391H7CJWdbxHtgP2KsLZyu9v5kQK9po44=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS0PR01MB5491.jpnprd01.prod.outlook.com (2603:1096:604:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sat, 15 Oct
 2022 17:31:32 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::1521:658f:6696:65b1]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::1521:658f:6696:65b1%7]) with mapi id 15.20.5723.032; Sat, 15 Oct 2022
 17:31:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v8 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHY3Xc4x9nhEXoTEUSC88Mqgf7asK4JP1wAgAZ9ZfA=
Date:   Sat, 15 Oct 2022 17:31:30 +0000
Message-ID: <TYCPR01MB59339FD821425B9A00A9EBF486279@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20221011134135.1930260-1-biju.das.jz@bp.renesas.com>
         <20221011134135.1930260-3-biju.das.jz@bp.renesas.com>
 <c41fe00b1e6eb5599da77f959294b05fd73bf069.camel@pengutronix.de>
In-Reply-To: <c41fe00b1e6eb5599da77f959294b05fd73bf069.camel@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS0PR01MB5491:EE_
x-ms-office365-filtering-correlation-id: 734bbbbf-78a7-4cc1-b918-08daaed318d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7edJ1x6SJiJ5ZI7ZnmH3p82umd1KDxsCad6VvQEmiEPXZm7sTM0wpGna8VBORWikCMc1+sl7z/9uMsYrKtPmOJneOBglockRbRULGKenSJ7MQLs77MvLtlwVYcucieOzReLX9qiRw1yuZdW0gWD1scrODP1v0j0oodQbSN9E01h4wLy03fu6llx+nwCmqAQE+HbMQgxQty/4MB3XMkrFrJ2DFfkaMywlKIgU7x8nCU7ZwjA5JAhjkn+YH51y4CuDNeHKU6Tv2QIALyO5mmNcozA5jog7w4sip/mUw164lO/YGewtLnHU3muf0llxCnHnQuvD0P+u1SAN3WgHdgNuEY3q/CH/he91djDLqMWBOe+YigmG15tEIR8p/rCax8h8NN3+LDB+BUjSNk9IPuQ0pmCqKgxRUFs8Pxw0kNlzmzEcseHm+N0MqVv690FJGiVpC6fezXDpH9iKRXU+YiQmvqwdO1G0lm7+lei3f8r22k5p2V0IqjaAkAoJUERLDJeX1++LlXNdO0mrDr5QFph02vdj1aSdP+SevyCTXyfu13jS7i4tBpGiax9lcNrYqiyByMFg0GqPiiwO8A0cppaJ26XbDOv+P5IM3hI1SykAQj7MEZbkg1EnBFHO6jh9Z4dg+9DljUVUSIvMOeoi3yANkTraP+bs3TkfFOqWe9IxG3bEFiCryHu1fHAjBxtUHoLSFSCwAk1zaGiE5k/wfkjy79RnZ68ThrS3syiTUVgpxMzrI2ZZzV1lH6eA/VCaUVOYAbZaX5zQ+Tv1oziQBNJ8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(38070700005)(55016003)(33656002)(86362001)(122000001)(38100700002)(83380400001)(316002)(478600001)(71200400001)(110136005)(54906003)(41300700001)(26005)(6506007)(7696005)(52536014)(8936002)(4744005)(9686003)(5660300002)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(64756008)(4326008)(2906002)(186003)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm8wdGNMcG1wK3hCNXpDU1ArUVdpdi9VU2FmMVBRNEtWWkRXdUZGRnNWL0pX?=
 =?utf-8?B?aTBLQXlyM0I1Q0dQb1ZMdHY1UTFEK3dpcElhN3NrK0RZTnIyUHBtTC9UelpX?=
 =?utf-8?B?eU9TY2xZMzJpQlY5blVEQjV6alNZWUF6TXYvRmY5UklkdFZEV3BwRTRzSGlX?=
 =?utf-8?B?VlVCbHFDeVovVkdtbHdiYjZXN3ROZnhnbUpZUlE3UzArZCs1UXFmay9hOXNR?=
 =?utf-8?B?REd6eEEvYysyWFF0ZFZlQUgrZVVRNnJJRUtGN1phRjlSb2I5NmxhdzNvTDhj?=
 =?utf-8?B?aUQ5bnppM1RFUmJBSGs3T1pEV2JGRHkraEdpQW9LaGZBQlVUcGRBcVc3K2pT?=
 =?utf-8?B?WFVvWG9GTmxPZWFScXJ2YTg4ZFhkR0RsSDkrVERJSlcvUU9UL0prZ05rZ2JC?=
 =?utf-8?B?ZWxuaENhUTI2bFZ6Z1JOYWlXYk5OZUNrbG45RTBGVHBpdGlvSlZYQXljNXZH?=
 =?utf-8?B?ckFLeEhUR3JGVEl6WUIyUkQ2cXBUc0tMcVZEeWV3MDNHTFhPMDRnL0ZDNkVn?=
 =?utf-8?B?dUppZXVqS0FidTVEY1hYdlJEc2VUZFYrYXJkeGNLN3JnMW1EK0hiVUlNdExu?=
 =?utf-8?B?YzMreDdXQ1h1blZLRFlMcXhCM1l0S2x3aFkzVEdQMG1wbllOazR6TUFIQUQv?=
 =?utf-8?B?STc1bkVqbURnZENubXE4NHYxbU03Z3R4cG1hNVl2c3VLcU5KQkY4QlJpTWg0?=
 =?utf-8?B?anc4Z1Z4K3VNbnMvbmZGYmxtdGdIVDFFdWZ4SHBYOWNCeDZYd1NvN2JtY3FP?=
 =?utf-8?B?NklPQjJsK1hRdTJmZGRlaU1wWnY4aGJFWk0vRG9vWGMyT0RnYlNEcXEvNFhU?=
 =?utf-8?B?UjdMOGl5YXZSVDc0Rm9XUjhyRjIydHAzWEJFcVZlSTUwamswWi93NkR3bTA5?=
 =?utf-8?B?N2NMOE51NThjd3lucFF3S09NWmxzSE9OUWRERDBwa3ZmTkhaL3k3a3RWU3BL?=
 =?utf-8?B?SzhRUjVhcy9ia3dia0NBZDJBUFg3UjhnYm81QjJwdXRiYkcyRzh0QmltMDhh?=
 =?utf-8?B?d1FsR1VBdTh5d082ajNwRmh6eVdJcjZOL1poOWlpWXI1bjZCeHM1Z0VON1lP?=
 =?utf-8?B?Z0p6eVFyK3JHRi9hdzZUamVweEVkK3VQazd2N0NTVlRQVUNiRE15bmxkUDVJ?=
 =?utf-8?B?R0V5eU1mT2o0Y0VTVkxUTzhVQk1aTlROalZIc3BaWU9HdXdXUGllLzJLNmQ4?=
 =?utf-8?B?ZzhidWxsZFR6Nnh3NndHenVsVHMxM1krUTdjZGZkc25CRnp2ZmdXam4xcnln?=
 =?utf-8?B?b2YvTVk0UjhPQit2L29KTHQ2T0x0WXU3dHUzZTVveE1CNXhFREsycVpJbGJX?=
 =?utf-8?B?Uk5GMnkwSmZ6RVZTVWxNQjc4d2JTYVMvRS9HTXlRd3J0NEZRWkV0WDI1bXk3?=
 =?utf-8?B?c0JZTjlnaXNYWFUrY1hPT3FQclQ0a3h1OXBYbDMveW9QTXFtZDB1aGdrYVl5?=
 =?utf-8?B?Y0NXZG4xWDBiMjBhUVNhQ0VpQWJCeVgwY3hBQ05WZ1BWYVV6Y2lVaW9IbmVQ?=
 =?utf-8?B?UzBJZFZIRHUrZmRCM2VQRUdwdWxqYW0yN0d6NUVLL0lCeEtqSWluemg2VlZB?=
 =?utf-8?B?bExuZWJxdWtnRzZYN0M4K2dYVFdiWUI1Rlh4WDZ4YkdSemxkdWFJZGlrRzNq?=
 =?utf-8?B?SVZldmV0OUgvUWxHcVo3WWowME5QMUppRjY5K2gyZ0QyYTFIMytQeXFIeTEr?=
 =?utf-8?B?SEc1Q2ljMUo3WWlhcXVKVndOb2poK2YrMlpyRlIwbXcvWTRlNHhxYlpMMGtu?=
 =?utf-8?B?NkJhTUp0UUVaMCtkU2pkem1kZjBYaHVRSSt2Rm9IcWVrTUt3WG5KZGxDWlNO?=
 =?utf-8?B?akI3dFQwbVBHMGJaTlRSRmNleU9MSmwzVkJBVEV6MzYzc3RwL2ZaS05mSExQ?=
 =?utf-8?B?VC9UNjhJUXN4T20rbFU0alo4R05WLzIyeDgzWjNxTUJJVSsybU1ISEVKbjdH?=
 =?utf-8?B?N0JQL1gyWHRiaFhKTEdYKzhmY2E4Skc2VXdiZ0RhNHR1Z2dGQ2ZXY2kzUGZL?=
 =?utf-8?B?QlIzZXVYcER2dzViTWZKb3hvMVhoZkJabnQzRFhUN1pQSVh4SS84ckRabzNM?=
 =?utf-8?B?aWIwVkd5a01hOHNvcSs4TG1TZ2g2aVFJQ1VsRW9vS3pubHFwUWJsdWRaREZi?=
 =?utf-8?B?NUFselFvLzN0OUdFd1hkMklTTytlUXEyRGFaQjQ3WFRUZzNJeWxqWHMreGRx?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734bbbbf-78a7-4cc1-b918-08daaed318d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 17:31:30.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpwLYOCJWt4N2jpt+3rHRiNpX0W8nM/e11V1NO0JdCAeFXEJ5x2Q9XEtyh3AUl60VLFBQ16eCwprfGt5Dj3y8ZK2Ap2F8mNtOXurBqDrti4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5491
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgUGhpbGlwcCBaYWJlbCwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjggMi8yXSBwd206IEFkZCBzdXBwb3J0IGZvciBSWi9HMkwgR1BUDQo+IA0K
PiBIaSBCaWp1LA0KPiANCj4gT24gRGksIDIwMjItMTAtMTEgYXQgMTQ6NDEgKzAxMDAsIEJpanUg
RGFzIHdyb3RlOg0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgaW50IHJ6ZzJsX2dwdF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+IFsuLi5dDQo+ID4gKwlyZXQgPSByZXNldF9j
b250cm9sX2RlYXNzZXJ0KHJ6ZzJsX2dwdC0+cnN0Yyk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIHJldCwNCj4gPiArCQkJCSAgICAgImNh
bm5vdCBkZWFzc2VydCByZXNldCBjb250cm9sXG4iKTsNCj4gPiArDQo+ID4gKwlyemcybF9ncHQt
PmNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIo
cnpnMmxfZ3B0LT5jbGspKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYs
IFBUUl9FUlIocnpnMmxfZ3B0LT5jbGspLA0KPiA+ICsJCQkJICAgICAiY2Fubm90IGdldCBjbG9j
a1xuIik7DQo+IA0KPiBJZiBkZXZtX2Nsa19nZXQoKSBmYWlscywgdGhlIHJlc2V0IHN0YXlzIGRl
YXNzZXJ0ZWQuIEJldHRlciBkZWFzc2VydA0KPiBhZnRlciBkZXZtX2Nsa19nZXQoKS4NCg0KV2ls
bCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24uDQoNCkNoZWVycywNCkJpanUNCg==
