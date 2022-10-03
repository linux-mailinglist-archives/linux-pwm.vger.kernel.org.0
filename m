Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203615F2E48
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJCJlq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Oct 2022 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJCJlT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Oct 2022 05:41:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70C606BC;
        Mon,  3 Oct 2022 02:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgqRe28V/bFCmnOPnpdzPeG95llG9f6PKiZ599E0+2ypQZyhAqWW4KMzxIAJICZteTnlm8EeZWvADOIdQBE6YZkz4bIfhOzMPSEbpnUl+nB02RWB6PnJkphGrjsyMZtPh3y3aowwSsLqamBC5v+tKxx3i+T9aTq9ji4xxqDA1yS+31/hkgoWYSDlA4O+0VHkTRDBJgT5zgKwtlHrXVoXV0HlT4aRme26sbYdn/3iW3krDT0BA7F7DZMk08LRtGXmqrehxTNaesAY0CHq9IZYqvq94OZbJNdbeATOQTxctx6gduAMuWOOBHJL3GvNi8J/wzNz0Lns489HdvuM+x488g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIRO1mrwpEi98zoFnSYwIaUbSzTNH1Hf9LQ6UycA7O4=;
 b=XWJokref4iAIC/8kLX/69Col3c1o7cbjbQeleiSN85QKBsDHF2T4Xa10jSOUrkMEUGccPn9vQiS5XKiB/n0uj7EZaPY4o4aIBrwyHXEB2EQ8VoZUsdu5cpCk8fg4Nj5vXahtdKXa0FIoIgsj4q3ADM/2Yp4X0ciRxL67oYuNxs7QIrpiK/6QgAD+dzYaD45tepZG0BD8r0dEafTBJYhIBTkAOMbOq67VUecgcHOpJ9YFJCZ81s1ePsenVkcVvxmEdQCYYGar2bhUfjAk4Y1SPN4Ef9+JMtam/elFxrq9uzCCc4fQtCKGkxl7P3oYqEVqsOLgu0KxJNZrpLSZBPfJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIRO1mrwpEi98zoFnSYwIaUbSzTNH1Hf9LQ6UycA7O4=;
 b=q8/bTjjrI+EeDCmkfa1kLXbUQx++Li2eXf2V8oCdYv/cBLBSDDMjwZhUTSjnQkCcqMo28d3dZjDroptNLLIyfMJZqcOde/BLepcuoCRiJmGuoqyHeEnKLn9BKL/WMctfZzw1Zza3zx+VCg/YiwcvdTUVLIrGHb8KDPa3ATfGknU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10049.jpnprd01.prod.outlook.com (2603:1096:400:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 09:34:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 09:34:44 +0000
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
Thread-Index: AQHY0+6TADmAt9m0c0u1ieTfUadBoq32sJKAgAABH3CAATHPgIACC6NggAJdkoCAAAsx0IAADI+AgAAATiCAAAkn8A==
Date:   Mon, 3 Oct 2022 09:34:44 +0000
Message-ID: <OS0PR01MB5922C02DBFCD5B262400E7A7865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzbcyxY839GlR71V@google.com>
 <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzqQC3gEzGksqYzk@google.com>
 <OS0PR01MB5922630991BABA41FAE06BBE865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzqj9/1TVEB1BZcL@google.com>
 <OS0PR01MB59222A065B460F2B72634577865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222A065B460F2B72634577865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10049:EE_
x-ms-office365-filtering-correlation-id: 54eeae0f-547b-4240-93e1-08daa52281a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxOHvl8mwCuQXB1V262By6ZylR2qAXlVwbnea3lc5tkqhtevo7E2RovGCAgGzquOr/GU0VMabBtgfOj5piWE/dQj9+/wY+lUpRyRHPbMRqTyPJaowKYw/ShvL7OwcyzCt0U8oqdZe0W79Cb64gnjV0qC5QA8P4SDbVhpM1BrpRXcp7sM7R2/J9gLWLFKltw+B8n2qElhglr81sv58ntb0u1az13lNjJmVtW0TG/ssbvhcuayX1WktEZXGMdk9lh1DeY8L1DBawVZBrBOtQ9FjwX5vkbGZnu1D0BkBmsUIWEK9wJFKJKxcga2p/NKE3KtQNryxbyIXfXkY9F9ZHVfEusdG5J3tbpBwMTL89BwWyYQO6TnfRJ6vB0ePBVi+drw/ZR1bExIz7AaK0zwSDuBRVnCJDtikhGtAeF+6L91awcY3mNJVPuEC19EZxWHeXVrxyFupiDWWvFhcREnVtEydYYgDtoeZ6FM4XzQZrGr0ODkyXaktQAbtMzeMJQhx5K98jGlND4PjjnQNAYV6EIvbpkP147FNmyxdon77KrzQJnyG/celeSFlVgjqNoRU0dSo1eS739bi/EkmoAWZWtL0x1UkXbfqii5bENnAqa7N26T87VKqWHVyYCH1hbGaCCQfkDpnQiAWKZyDr2MnwS7LVb1RrW7t2ERZkFIC1vfD+Aoqr/9zGApgQNp7FPy43isgvvJbOYRf4ybVy0Sz9CG/qVuD1dBZsGAHHrc3gadykhio+rTEU9QeUUuXrCqGkHlpTNsQaYPNtQQQqcPzLV3oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(54906003)(2940100002)(26005)(9686003)(7696005)(6506007)(6916009)(4326008)(66946007)(76116006)(316002)(8676002)(71200400001)(66476007)(66556008)(478600001)(64756008)(66446008)(38100700002)(55016003)(122000001)(86362001)(33656002)(38070700005)(83380400001)(186003)(5660300002)(8936002)(41300700001)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akdUQlRWeExvQXFvVHo4bDlGV04vMmM0L1RLSzI0LzhyWjlxbVZHU3VJWEg0?=
 =?utf-8?B?WTU1VmV1ZFhmSllsZjFHYjR2ZU5YOWVJNG95Q0hnUHprVzlQeERYWkNxRWlK?=
 =?utf-8?B?YmpFRi9makE2aTFQcFI5Sm0rR09ONjBuMWtXUDhXcTFJSXdXVlNOZzdnMVNx?=
 =?utf-8?B?clkyVEhCbWdSTVhGbkpLQUdEQUlGUk42UDlzTzNOeVBRTE1GVnNTWWhmRnB5?=
 =?utf-8?B?bERSemVCcm5GWS90cDVyVVQ5MzVLUnMxUG5rTmdmT1VHVkVyaTY5b3FXNEMr?=
 =?utf-8?B?ZXpXaHIwUEoxSCthVitFZjJpRTR1djdTNHFpaVExZFZVTDhQZzhJM1JNbmZu?=
 =?utf-8?B?RERyYjMrMzFudks0SmhqZWM2NVlOT3A0VFc0ak0xR1BWdkFaM2ZNWlFaL1Ro?=
 =?utf-8?B?M1l2Y3VGUUZxVmxJR29YVGhoZGt5R3VqM0RIK0gwQWVCTnNhNC80VFRyV2lk?=
 =?utf-8?B?bU9KazBKWHZ1QWJBcHlVajhkWmQxdGlUUlkrVEU4TVBONjYvNnVHZlpsVTNp?=
 =?utf-8?B?RHAvclFKTW56R21pZUxtK1ZGUUJYV3BDODJZdXNJYkQzRVVrS0FzdWd0bWxK?=
 =?utf-8?B?bG9lVTMxS3d3VGZtaUVGdDFKQVM4ZThCRVJBbWtRUnZBV0wzaUJSU0ZTZW1u?=
 =?utf-8?B?N25BREljd1dOOGl0anZjblJ2RlpzZTNTMmk1WHRnNXp6QlRGK1BNQmZzZmVS?=
 =?utf-8?B?ZnpkWHNCaDEybGtTTXRSTXlqbW90UDhOaitBalMrQ1hqZEsxc25SekUxU1do?=
 =?utf-8?B?OW1pc2lRaDJXejZ2aDY1OEFVK0dYdjFTVlkwZWNwamZ6bGNEUG5lMnRMcnhF?=
 =?utf-8?B?d3k3aVg3dU1aTVhlKzlqOERQWmI2Tk5mT2RDNUdnY2tYQWJ2aHgxbFlVV2ho?=
 =?utf-8?B?WlFtcHJDMVkwamhncDhjTHBKQ25RSWUyMWl1eEJ2V000Y0pSQm5vUFdlanhi?=
 =?utf-8?B?cktNN2oycTlKbUxpbGRBbmNPMTFKUDMwTjlRN2lET1d3Ui9YeHdHTjVRR25p?=
 =?utf-8?B?NjVaeGl5Vi93MGY4ZnV4Z0RQdFlUUnBaSGxTL3Y0VG13bFlWdUJ5YUxNYXRX?=
 =?utf-8?B?NXViMkt2aUdoMFNlczI1TWlqTktrRjdOTWkyc0pXU3FmOUVydHI3ZUVuc3lY?=
 =?utf-8?B?N29IV0ZtSE5SWWF0R2Y2Y0FSclFjbnluVkFBTmM5VkkwOUZOcGx0T3BOeVFk?=
 =?utf-8?B?cWZlNDE2dGRyeU1FeWZlSVJFeWRTellndlNONjRRWG9nSERhZ1B0OGw5ampk?=
 =?utf-8?B?UWJuTGRrTjIzdlpKb1NqVDBtRUhmcm5Lb0J4U3o3b2NHbXgxSDJRb3dVQi9N?=
 =?utf-8?B?d1pLaTJrVFJpamZERFZTM3Vib2h2amdmYVNHQU5WbFpoYnY5ZGVPUjJvM2kw?=
 =?utf-8?B?SVZLMmdXcVF3elZ1KzJrbVVqQmpPTHVwQjhUQ1cxekdhMjh6a1pOUWpaZDJx?=
 =?utf-8?B?TGw5Ui9mUnVINkhmZ09QRmNFL1hmSk5uQktpS2doTVZCUzFwSXp5aEo1alhK?=
 =?utf-8?B?UTRWaFVRUGpnYlZUWmhpRDRBU28zeFJVN1BMcWdGSEkxSUxrVHJselNBaVFk?=
 =?utf-8?B?SERYNzF4UGVrenhxYnNncXNzUlQrWDR3VXp3NXdlTitjeDZTeVdKcDAyZEth?=
 =?utf-8?B?RGVrSi9EN21BM2tBWUhHTEVrcmFoMnFHbUw5REFIWWh3aGxrYXNSdkJTTG85?=
 =?utf-8?B?YXpxaEJQQUdIV0p0Snl2ZG1taWd4ZVVPQXdJRzZNb1NxeU5CK2hxVTRHNmZ1?=
 =?utf-8?B?UERtZ3ZqSUVYOTdxcWswK09DNTN3REJjMm5zaFJaMXpMaHVGY3RkS29jUjMy?=
 =?utf-8?B?aFllMkg4STVJV0R6K25FTVkvcG1UL3REZGEvSm8wamltMnQ4SzdjQmFzZE54?=
 =?utf-8?B?a3pSNzNaY3JGdmNyMVQ1S1Z0NDFnNTZNV0JWZG5WV3A2SGZ2WkFhZi8yMHBk?=
 =?utf-8?B?dzZTcW1SM0djTmpWc0QwRGJlRUQ3dXpKQXRqZXpUek95TE50cFhOYzExQVM3?=
 =?utf-8?B?Y0kzK0VoSUxhalB5NFM3Rk5yZk5YWkdHYWcraGdQRmh0Zko1K21mdFhjWVNr?=
 =?utf-8?B?eC95M0JZampFM2dhZ3RiY0REd2ZEMHpRMlIxVWU0L21iRG5iUGFRQTI0eU1D?=
 =?utf-8?Q?5W4Ohy9rsvl90OiYnn7BA0VVb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eeae0f-547b-4240-93e1-08daa52281a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 09:34:44.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjsbLWxkAhsroFHr0s7bWnksEPVfsRt3/S7SSRLm6M7xDDVNTRXvBLBF390V712I6WHv7O04pQkGKHaRzVccyEZ9Z8q32E7rAV5fpxXZ5CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGVlIEpwbmVzLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0OiBS
RTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRpbmdzOiBtZmQ6IHJ6LW10dTM6IERvY3VtZW50DQo+
IFJaL0cyTCBNVFUzIFBXTQ0KPiANCj4gSGkgTGVlLA0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIFJGQyAzLzddIGR0LWJpbmRpbmdzOiBtZmQ6IHJ6LW10dTM6IERvY3VtZW50DQo+ID4gUlov
RzJMIE1UVTMgUFdNDQo+ID4NCj4gPiBPbiBNb24sIDAzIE9jdCAyMDIyLCBCaWp1IERhcyB3cm90
ZToNCj4gPg0KPiA+ID4gSGkgTGVlLA0KPiA+ID4NCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCBSRkMgMy83XSBkdC1iaW5kaW5nczogbWZkOiByei1tdHUzOiBEb2N1bWVudA0KPiA+ID4gPiBS
Wi9HMkwgTVRVMyBQV00NCj4gPiA+ID4NCj4gPiA+ID4gT24gU2F0LCAwMSBPY3QgMjAyMiwgQmlq
dSBEYXMgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+ID4gSGkgTGVlIEpvbmVzLA0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRpbmdzOiBt
ZmQ6IHJ6LW10dTM6DQo+ID4gRG9jdW1lbnQNCj4gPiA+ID4gPiA+IFJaL0cyTCBNVFUzIFBXTQ0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIFRodSwgMjkgU2VwIDIwMjIsIEJpanUgRGFzIHdy
b3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSGkgTGVlIEpvbmVzLA0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRp
bmdzOiBtZmQ6IHJ6LW10dTM6DQo+ID4gPiA+IERvY3VtZW50DQo+ID4gPiA+ID4gPiA+ID4gUlov
RzJMIE1UVTMgUFdNDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIDI5
IFNlcCAyMDIyLCBCaWp1IERhcyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gRG9jdW1lbnQgUlovRzJMIE1UVTMgUFdNIHN1cHBvcnQuIEl0IHN1cHBvcnRzDQo+IGZv
bGxvd2luZw0KPiA+ID4gPiA+ID4gPiA+ID4gcHdtDQo+ID4gPiA+ID4gPiBtb2Rlcy4NCj4gPiA+
ID4gPiA+ID4gPiA+IAkxKSBQV00gbW9kZSAxDQo+ID4gPiA+ID4gPiA+ID4gPiAJMikgUFdNIG1v
ZGUgMg0KPiA+ID4gPiA+ID4gPiA+ID4gCTMpIFJlc2V0LXN5bmNocm9uaXplZCBQV00gbW9kZQ0K
PiA+ID4gPiA+ID4gPiA+ID4gCTQpIENvbXBsZW1lbnRhcnkgUFdNIG1vZGUgMSAodHJhbnNmZXIg
YXQgY3Jlc3QpDQo+ID4gPiA+ID4gPiA+ID4gPiAJNSkgQ29tcGxlbWVudGFyeSBQV00gbW9kZSAy
ICh0cmFuc2ZlciBhdCB0cm91Z2gpDQo+ID4gPiA+ID4gPiA+ID4gPiAJNikgQ29tcGxlbWVudGFy
eSBQV00gbW9kZSAzICh0cmFuc2ZlciBhdCBjcmVzdCBhbmQNCj4gPiA+ID4gPiA+ID4gPiA+IHRy
b3VnaCkNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFNob3VsZG4ndCBhbGwgdGhp
cyBnbyBpbiB0aGUgUFdNIGRyaXZlciBiaW5kaW5nPw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBMb29rcyBsaWtlIGF0IHRvcCBsZXZlbCBNVFUzIElQIHByb3ZpZGVzIHNpbWlsYXIgSFcN
Cj4gPiA+ID4gZnVuY3Rpb25hbGl0eQ0KPiA+ID4gPiA+ID4gbGlrZQ0KPiA+ID4gPiA+ID4gPiBi
ZWxvdyBiaW5kaW5nIFsxXSwgd2hlcmUgdGhlcmUgaXMgYSBjb3JlIE1GRCBkcml2ZXIgYW5kDQo+
IHB3bSwNCj4gPiA+ID4gPiA+ID4gY291bnRlciBhbmQgdGltZXIgYXMgY2hpbGQgZGV2aWNlcy4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBQcmV2aW91cyBtaXN0YWtlcyBhcmUgbm90IGdvb2Qg
cmVmZXJlbmNlcyBmb3Igd2hhdCBzaG91bGQNCj4gPiBoYXBwZW4NCj4gPiA+ID4gaW4NCj4gPiA+
ID4gPiA+IHRoZSBwcmVzZW50IGFuZCB0aGUgZnV0dXJlLiA9OykNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFdoeSBkbyB5b3UgdGhpbmsgdGhhdCByZWZlcmVuY2UgaXMgbm90IGEgZ29vZCBvbmU/IEkg
YmVsaWV2ZQ0KPiA+IHRoZXJlDQo+ID4gPiA+ID4gc2hvdWxkIGJlIHNvbWUgcmVhc29uIGZvciBp
dC4NCj4gPiA+ID4NCj4gPiA+ID4gSSBkaWRuJ3QgZXZlbiBsb29rIGF0IGl0Lg0KPiA+ID4gPg0K
PiA+ID4gPiBXaGF0IEkgImJlbGlldmUiIGlzIHRoYXQgZG9jdW1lbnRhdGlvbiBmb3IgZWFjaCBm
dW5jdGlvbmFsaXR5DQo+ID4gPiA+IGJlbG9uZ2luZyB0byBhIHBhcnRpY3VsYXIgc3Vic3lzdGVt
IHNob3VsZCBsaXZlIGluIHN1YnN5c3RlbSdzDQo+ID4gPiA+IGFzc29jaWF0ZWQgZG9jdW1lbnRh
dGlvbiBkaXJlY3RvcnkgYW5kIGJlIHJldmlld2VkL21haW50YWluZWQgYnkNCj4gPiA+ID4gdGhh
dCBzdWJzeXN0ZW0ncyBhc3NvY2lhdGVkIG1haW50YWluZXIuDQo+ID4gPg0KPiA+ID4gSWYgSSBh
bSBjb3JyZWN0LCBNRkQgaXMgc3Vic3lzdGVtIGZvciBjYWxsaW5nIHNoYXJlZCByZXNvdXJjZXMN
Cj4gPiBhY3Jvc3MNCj4gPiA+IHN1YnN5c3RlbXMuDQo+ID4gPg0KPiA+ID4gSGVyZSBzaGFyZWQg
cmVzb3VyY2VzIGFyZSBjaGFubmVscyB3aGljaCBpcyBzaGFyZWQgYnkgdGltZXIsDQo+IGNvdW50
ZXINCj4gPiA+IGFuZCBwd20NCj4gPg0KPiA+IFdoaWNoIEFQSSBkbyB0aGUgY29uc3VtZXJzIHVz
ZSB0byBvYnRhaW4gdGhlc2Ugc2hhcmVkIHJlc291cmNlcz8NCj4gDQo+IFRoZXkgbmVlZCB0byB1
c2UgTUZEIGRyaXZlciBBUEkgdG8gZ2V0IHNoYXJlZCByZXNvdXJjZXMuDQo+IA0KPiA+DQo+ID4g
PiBUaGV5IGFyZSBjaGlsZCBvYmplY3RzIG9mIE1GRCBzdWJzeXN0ZW1zLiBUaGF0IGlzIHRoZSBy
ZWFzb24gaXQgaXMNCj4gPiBpbiBNRkRuZGluZ3MuDQo+ID4NCj4gPiBJZiB0aGUgcHJvcGVydGll
cyBiZWxvbmcgdG8gdGhlIGNoaWxkLCB0aGV5IHNob3VsZCBiZSBkb2N1bWVudGVkIGluDQo+ID4g
dGhlIGNoaWxkJ3MgYmluZGluZ3MuICBTaG92aW5nIGFsbCBmdW5jdGlvbmFsaXR5IGFuZCBieSBl
eHRlbnNpb24NCj4gYWxsDQo+ID4gZG9jdW1lbnRhdGlvbiBpbnRvIHRoZSBNRkQgZHJpdmVyIGFu
ZC9vciBiaW5kaW5nIGlzIGluY29ycmVjdA0KPiA+IGJlaGF2aW91ci4NCj4gDQo+IERvIHlvdSBo
YXZlIGFuIGV4YW1wbGUsIGhvdyB3aWxsIGl0IGxvb2sgbGlrZSwgaWYgdGhlIGJlbG93IGJpbmRp
bmcgdG8NCj4gYmUgcGFydCBvZiBwd20gYW5kIGxpbmtlZCBhZ2FpbnN0IHRoZSBwYXJlbnQgTUZE
IGRyaXZlcj8NCj4gDQo+IA0KPiArICAiXnB3bUAoWzAtNF18WzYtN10pKyQiOg0KPiArICAgIHR5
cGU6IG9iamVjdA0KPiArDQo+ICsgICAgcHJvcGVydGllczoNCj4gKyAgICAgIGNvbXBhdGlibGU6
DQo+ICsgICAgICAgIGNvbnN0OiByZW5lc2FzLHJ6LW10dTMtcHdtDQo+ICsNCj4gKyAgICAgIHJl
ZzoNCj4gKyAgICAgICAgZGVzY3JpcHRpb246IElkZW50aWZ5IHB3bSBjaGFubmVscy4NCj4gKyAg
ICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgZW51bTogWyAwLCAxLCAyLCAzLCA0LCA2LCA3IF0N
Cj4gKw0KPiArICAgICAgIiNwd20tY2VsbHMiOg0KPiArICAgICAgICBjb25zdDogMg0KPiArDQo+
ICsgICAgICByZW5lc2FzLHB3bS1tb2RlMToNCj4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiAr
ICAgICAgICBkZXNjcmlwdGlvbjogRW5hYmxlIFBXTSBtb2RlIDEuDQo+ICsNCj4gKyAgICAgIHJl
bmVzYXMscHdtLW1vZGUyOg0KPiArICAgICAgICB0eXBlOiBib29sZWFuDQo+ICsgICAgICAgIGRl
c2NyaXB0aW9uOiBFbmFibGUgUFdNIG1vZGUgMi4NCj4gKw0KPiArICAgICAgcmVuZXNhcyxyZXNl
dC1zeW5jaHJvbml6ZWQtcHdtLW1vZGU6DQo+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gKyAg
ICAgICAgZGVzY3JpcHRpb246IEVuYWJsZSBSZXNldC1zeW5jaHJvbml6ZWQgUFdNIG1vZGUuDQo+
ICsNCj4gKyAgICAgIHJlbmVzYXMsY29tcGxlbWVudGFyeS1wd20tbW9kZTE6DQo+ICsgICAgICAg
IHR5cGU6IGJvb2xlYW4NCj4gKyAgICAgICAgZGVzY3JpcHRpb246IENvbXBsZW1lbnRhcnkgUFdN
IG1vZGUgMSAodHJhbnNmZXIgYXQgY3Jlc3QpLg0KPiArDQo+ICsgICAgICByZW5lc2FzLGNvbXBs
ZW1lbnRhcnktcHdtLW1vZGUyOg0KPiArICAgICAgICB0eXBlOiBib29sZWFuDQo+ICsgICAgICAg
IGRlc2NyaXB0aW9uOiBDb21wbGVtZW50YXJ5IFBXTSBtb2RlIDIgKHRyYW5zZmVyIGF0IHRyb3Vn
aCkuDQo+ICsNCj4gKyAgICAgIHJlbmVzYXMsY29tcGxlbWVudGFyeS1wd20tbW9kZTM6DQo+ICsg
ICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gKyAgICAgICAgZGVzY3JpcHRpb246IENvbXBsZW1lbnRh
cnkgUFdNIG1vZGUgMyAodHJhbnNmZXIgYXQgY3Jlc3QgYW5kDQo+IHRyb3VnaCkuDQo+ICsNCj4g
KyAgICByZXF1aXJlZDoNCj4gKyAgICAgIC0gY29tcGF0aWJsZQ0KPiArICAgICAgLSByZWcNCj4g
KyAgICAgIC0gIiNwd20tY2VsbHMiDQo+ICsNCj4gDQo+IGV4YW1wbGVzOg0KPiArICAgICAgcHdt
QDMgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMscnotbXR1My1wd20iOw0KPiAr
ICAgICAgICByZWcgPSA8Mz47DQo+ICsgICAgICAgICNwd20tY2VsbHMgPSA8Mj47DQo+ICsgICAg
ICAgIHJlbmVzYXMscHdtLW1vZGUxOw0KPiArICAgICAgfTsNCj4gICAgICB9Ow0KPiANCj4gDQo+
IENoZWVycywNCj4gQmlqdQ0KPiANCj4gPg0KPiA+IExvb2tpbmcgYXQgaXQgZnJvbSBhbm90aGVy
IHBlcnNwZWN0aXZlLCBJIGNhbm5vdC9zaG91bGQgbm90IHJldmlldw0KPiA+IFBXTSwgUmVzZXQs
IENvdW50ZXIgb3IgVGltZXIgYmluZGluZ3MsIHNpbmNlIEkgZG8gbm90IGhhdmUgdGhlIGxldmVs
DQo+ID4gb2Ygc3ViamVjdCBhcmVhIGtub3dsZWRnZSBhcyB0aGUgYXNzaWduZWQgbWFpbnRhaW5l
cnMgZG8uDQo+ID4NCj4gPiBQbGVhc2UgcGxhY2UgYWxsIHN1Yi1zeXN0ZW0gc3BlY2lmaWMgYmlu
ZGluZ3MgaW4gdGhlaXIgY29ycmVjdA0KPiAobGVhZikNCj4gPiBiaW5kaW5ncyBhbmQgbGluayB0
byB0aGVtIGZyb20gdGhpcyBvbmUgKHJ1biB0aGlzKToNCj4gPg0KPiA+ICAgZ2l0IGdyZXAgXCRy
ZWYgLS0gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC8NCg0KVGhhbmtzIGZv
ciB0aGUgcG9pbnRlciwgSSBnb3QgcmVmZXJlbmNlcyBbMV0gYW5kIFsyXS4gSSBjYW4gbW9kZWwg
bGlrZSB0aGlzLA0KSWYgZXZlcnlvbmUgb2sgd2l0aCBpdC4NCg0KWzFdIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQva29udHJvbixzbDI4Y3BsZC55YW1sDQoNClsyXSBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2tvbnRyb24sc2wyOGNwbGQtcHdtLnlh
bWwNCg0KQ2hlZXJzLA0KQmlqdQ0K
