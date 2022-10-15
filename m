Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270305FFA62
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Oct 2022 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJON4k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Oct 2022 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJON4j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Oct 2022 09:56:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CB481C5;
        Sat, 15 Oct 2022 06:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grQKAeg7ZYfuMYSuwwmSjqrRR9wM3iGEcQjzpWZ0SNy921ctI/6GHc4CBrIZVkJtssGYlmD2BbV/qL0TFERuI+2tvS+L8etdFz3pyQNUv98V56DnPHY9RqiTU7pwuvYcaT8Ode3qknJinAXEtWmAEhfKL7UfdjOLJds2b59ZulgnEYj76XajDz+RckEJtaqQ2prA5s/lETSmQ0do0xwnUJ3Q2drIweQEa2t4Pup5EJfmD6u79F9/BlgIRWlJQCU/xqcknQiPc95Uc/6zNFNNMz8D1lZcH/d7cqsj5yj8pWIYhTXVwumziM3f++DSAro4ONxYG7jy+qNLx75x8ttHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcTww735DYQqYyaa5IJ/mO3y+sz5aaFBhBdkhm1gzok=;
 b=ShnyisRcE4y9//EzopE9ldXwtAcV9o2W11xiQzrVCHQPUJ+lBvlR7eb3rm+NdotVVi6hZd9ce0LramQgZMsDCLJZsTeyfCrfmxEav8E2bjmNdiTbDyGoZasaIZXHoX82Ak2G7l+wbq89oWDdS6Y8hMPCUul3B8Y5Y1IePEiq2iQ+iuxhG4cmoTt7H6q+/PrXTy8/+5WBkmDwRhi12Cx8FfHdtkQLB/T+ecHYExRht4tHVcvZ0yTqIF/ujwyvnm2j7SUW16dBeacvUY5VICrz8pNChPPmjjIGK8RZEF3Jt7USwb5Dw/FPzRFcwxouX94Cz7vNjI+e5faeJcpq0FLQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcTww735DYQqYyaa5IJ/mO3y+sz5aaFBhBdkhm1gzok=;
 b=NeRZKowztGS5VtMSoRKko0YSqP2Ny8CzhOXzYFqwebgqw+EAqkpSLnzctz/nlXFBZfsNQQxYK/gXyNQPvDYZCDRTXbk57eudn061fEiXkM8Jdt1vdF1tg3vwLIJou8tpEp4QqyHQD0UXDPoNY2HGBaDml/rpifpeM497KVS30us=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6109.jpnprd01.prod.outlook.com (2603:1096:400:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Sat, 15 Oct
 2022 13:56:35 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5723.030; Sat, 15 Oct 2022
 13:56:35 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Lee Jones <lee@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Topic: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Index: AQHY3Lf1ZjO75wmqM0qPUfqcMk9xD64JjDKAgAACnKCAABKoAIAAATcwgAADlICAAAF6AIAAAXgAgAAA2nCAAAOggIAF1F/w
Date:   Sat, 15 Oct 2022 13:56:34 +0000
Message-ID: <OS0PR01MB59221B7B21E13CEC0BDC1B2786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
 <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
 <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <f12dfcd3-ef5c-b422-c00c-35cef082a3ff@linaro.org>
 <OS0PR01MB5922E406D2711AA6B8CD632C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ddfb11e0-0704-1600-d89c-ec8ca1650c38@linaro.org>
 <OS0PR01MB5922130811695F9B906EA62E86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <7b8f1097-e56d-2cb9-337d-c7d771eca6e4@linaro.org>
In-Reply-To: <7b8f1097-e56d-2cb9-337d-c7d771eca6e4@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6109:EE_
x-ms-office365-filtering-correlation-id: dadf1bc6-19b9-47cc-c1cc-08daaeb5128e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmP9Czd5B4/dtw+KncvWWjtEtISdx0I/K5pm68m+B/eYSD3Mu0fJXv5KsjFJwvIGPD7niPI6hkK8SaV1sUNn6I4UK4M6Dg/hZwWn2qGgxeQy0bCx0RykHaoBZkAkeIupKp5gg/QKKg8qDwQGHl+Qv+j2p+jIlrm5w0ElfgwQmA4dvwFDhpoEGSk5FbKSZbvJLc6zBUElz+PVS9fXT+Kf2ypMjqJEaSONHZx+8x0odH0FggGNywtaGV7Emq0U+FbfVSLoSgoF/DiQNzyoCUMonjkHLI/kZXuvpqNnOPuQpkEK7y+vPeLo37iU4sgGdu1zxiIkdmjOMvttwMDy0DrImficVg6KmRMw+A7ucOdsxR4a3zAmUwF942lUJu0Rg6nbiOm3+C56QmfALmslDPb7qyGckzwHlcB+tknhfmEOkCRwFyw6aBDPEvnIZCD+/bqmn3OrVwuZFZCm4+QdguSXJVY5LPgdg7XzoZwwGd0Dvhb8Cs+eD5eQM2FPudwniMHveCmmhF1aoTSk5WgOtcdJqRrhIRhQXGLbsfrIIYChYNmoSo4sy/Obpw2+ff75KZhpb354IAy8GepGMqFubVC2vEVttm5jCiwZXxktHa6/LM5PH65hrWCiWoN6OUBqhcc3eSbCjA2f7p7iAYzl8MAM5+ta2LBTwARfgHHda9WPjtL/LypWiyA9zXCkzT63OFHpHIuusWy4uqq8Eh8hMLKkt9khCv43OHBFk8DHhPrkL0PODc2/r8uuLBUfJQUHuggejd4L/Yiyop79tIdDgj0O6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(53546011)(6506007)(7696005)(41300700001)(2906002)(186003)(83380400001)(52536014)(8936002)(9686003)(38070700005)(33656002)(26005)(122000001)(5660300002)(38100700002)(86362001)(55016003)(478600001)(71200400001)(54906003)(316002)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QytuWmN5bXczSzhWdlBzbTMxZTN3RjQ5MjBQU3ZQK3BpVm4xUWNLRzlIUzhF?=
 =?utf-8?B?amRxNUUwVlVCQlY5SHRqZHBNYkhycDFoWU5JRWJvMFM3YkM3YzBINlhZYmFG?=
 =?utf-8?B?WFFKbExDbGlLYS90WXRIWXpadU4wTGhJM3JrM0JsREpkVkRDTHVSNjdLUnFt?=
 =?utf-8?B?VngyTC9FZzlSNmpnUi9rOERXdnF1N1FQR2N3aVg5ejN3ZWJCMnUzbzBhQnA5?=
 =?utf-8?B?N280UkZJRWdGUmo3ZTZHR0w5TXltZVM5cjVZMll6Uk9md2wxV3VvRWliTEEw?=
 =?utf-8?B?eC9tZGZZakhqcDduKys3WTVva1NhTGkrRVVnbVUzZXlUTVMwQ1BKUEVhN0Jj?=
 =?utf-8?B?NXd6Rmk4bERFQjRnNUhtcXpGUXlLMVdFQmtSa1AzWklSZkh2cDdoVkFoaTUx?=
 =?utf-8?B?ajNPRUFPUDlVRTJNVVdBMUJXZWdPTC81RUJIOFBtZUZ5M0EzZ0trVjFrTGlI?=
 =?utf-8?B?UWlCcHRFTFV6Q0dFSXh5bXhKME10Z2NmZ3RIS2tiTVZQZmcvMjRNaS9DU2c2?=
 =?utf-8?B?VGhZb3hGNndNWHNOWFVMeDdPQ1VoT1QzbkhNZ2ZkVFgxdWUxMlVzV2NVQUNv?=
 =?utf-8?B?RW5lMUdRMnU2TlE4MjF1eG16U3U3UzdlUkNFUzd1Z3UwZmh3bm5HN0pxcEZG?=
 =?utf-8?B?a2Vxb1A2dndicmg5aUZvWllyTGpYcnduZVBBUTM5Ymx3WStNZnF5ejlwK0FS?=
 =?utf-8?B?ek56bi9FeDdXeTRLa0lCVDl4cUlScHV2b085SGw5allBSG1kSHV2OFA4Q1Zs?=
 =?utf-8?B?dGxyTDU3ZG5samFVc0pzaU5MZStaMTNQK0tiQ3NiQ1E2dVVqYWxzNEJpQitu?=
 =?utf-8?B?T0dUYnBDbnJhWTdsdk9oTmVNYnpFV0xYdHZORzNleUV3NENBVmxNam9nVmVZ?=
 =?utf-8?B?RWY3dW44VCtEVDdvWklZcTh5SXgwNW5lRFNhZ0pmdG1KTWJ2aHBrL1VVc0d0?=
 =?utf-8?B?UE1rTDc4MEVpVGVDSkwwdzBSblFyKy9NbGxWbnlJbVo2UjhkUGpHdWZza0FZ?=
 =?utf-8?B?K1p3azZJRmorY0wxYlVHMTFaZnFsNmp1RzR0WWh4L003L0kzOTZYL1M4MzJi?=
 =?utf-8?B?N1ZoTzFBTXZXT3c2ckNUSGFZbkZlUFp4MTBJUWhQRWszRTQ4Y3NZNDFiNmlZ?=
 =?utf-8?B?YUpLL01kNmIwWDZuUzM4SzJyNlhNSEZxTXlHaFVhaE5DL2VkeWh2T055MVdO?=
 =?utf-8?B?b1hJT2V6V2VBajZEN1BEY1lFNU1oR2ZTK3cydm1KY1ZHMUtwYkUwVU5HYjFw?=
 =?utf-8?B?ZjdBalVyZlljd3pRVENDc1FjRDN5YjdOSkZFSVBXMDloSjVTanV0SlhJS3R3?=
 =?utf-8?B?dUp0NUZoSEppOUVaNUd1dEI0dFg3dlN1RmE4c1IxbzF3ZDlRelNFaElHVjlJ?=
 =?utf-8?B?MUFTL2hvRWZIbXprTkh2MnMvMUtiWWtVRW1Na2prdFd4MzFsOGpLaXM0Tzdp?=
 =?utf-8?B?Tk5zYUJxTTdzUU9TMHZQQkdtVDRvckRjSUtnQVl3NUNqZGtRdXlSaWtxVTgr?=
 =?utf-8?B?Yk1iL2hIVHNmQjVEY0JxSzlGY2JiYlMvNHMzUkFpRkRFNTJqZFkrKzhEalVR?=
 =?utf-8?B?dmRQY3pLR21YNW9Xb0V2Z2lQM1NCNVhOa3RMR01seG84cU1jckVaV0R6WUNX?=
 =?utf-8?B?Z1JFcy9CeHpMSExBdndCRm5LUUNMbDM5U0prUnVqNXJhRjhYeURkSU1jOTJJ?=
 =?utf-8?B?akRGK3NEOUxXdllxL2JXOXVvdjRVT0xvbUJpYWJCYjdxSTgxUXpWQWprU01M?=
 =?utf-8?B?M21yUGNKL09GYWt0RWNoazA0ZWhFRWFGYWpBV3d3d3lPNjhIaTVJZFM3d0xu?=
 =?utf-8?B?M0FQVDFzU3d1TDRlTDNSR1lZQ0JoZnJIdUttY3hsY3NIU1BBTmZ5bTVobGFu?=
 =?utf-8?B?SnB4SDE3RldVTXhHTmZTSUc5Zmtpa081Ym9WenorV28vYVJVeGZQb00wTGVV?=
 =?utf-8?B?VDVTTHE5Y2dZdTdmdEtYZWhsSmRURnV3UENaUTVWNDVTbWJnejhJMVhzMml2?=
 =?utf-8?B?YWlkaTNZbGNacjBEZ3hLK2xwbUE5ak1ONjRFTlhPRGpBMktlTzVGeDliTXVF?=
 =?utf-8?B?TitmZWozaXdrQ2hMeHRLb1BWTlU3YVJoUUppckNkdFErZkFiY0QwK2RTS0Ra?=
 =?utf-8?Q?ZYFGwCW4MuiFQh2td537K0lm/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadf1bc6-19b9-47cc-c1cc-08daaeb5128e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 13:56:34.9693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5w4ompn3PRyBWJ8lFvTLTnP+cO9MpgAi0a0F0rQpusKRe1vQnkgYSWQxCgxdhG7APEJ/SVrJo+oqcThdzCMOQTiswuByZIYs/bMfvG+0wXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNF0g
bWZkOiBBZGQgUlovRzJMIE1UVTMgUFdNIGRyaXZlcg0KPiANCj4gT24gMTEvMTAvMjAyMiAxNjo0
MywgQmlqdSBEYXMgd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC80XSBtZmQ6
IEFkZCBSWi9HMkwgTVRVMyBQV00gZHJpdmVyDQo+ID4+DQo+ID4+IE9uIDExLzEwLzIwMjIgMTY6
MzUsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNvIG5vLCBoZXJlIGFuZCBp
biBvdGhlciBmaWxlcyAtIGRvbid0IHB1dCBzdWJzeXN0ZW0gc3BlY2lmaWMNCj4gPj4gY29kZQ0K
PiA+Pj4+Pj4gbGlrZSBQV00gb3IgdGltZXIgaW50byBNRkQuDQo+ID4+Pj4+DQo+ID4+Pj4+IFdo
ZXJlIHNob3VsZCBkbyB3ZSBwdXQsIGlmIHRoZXJlIGlzIHNpbmdsZSBkcml2ZXIgdG8gYmUgYmlu
ZA0KPiA+PiBhZ2FpbnN0DQo+ID4+Pj4+ICJyZW5lc2FzLHJ6LW10dTMiIGFuZCByZWdpc3RlciBm
dW5jdGlvbmFsaXRpZXMgZm9yIHB3bSBhbmQNCj4gPj4gY291bnRlcj8/DQo+ID4+Pj4NCj4gPj4+
PiBBZ2FpbiAtIGhvdyBiaW5kaW5nIGlzIHJlbGF0ZWQgdG8gdGhpcyBwcm9ibGVtPyBJZiB5b3Ug
aGF2ZQ0KPiA+PiBzZXBhcmF0ZQ0KPiA+Pj4+IGRyaXZlcnMsIGUuZy4gY291bnRlciwgdGltZXIg
YW5kIFBXTSwgYWxsIGdvIHRvIHRoZWlyIHJlc3BlY3RpdmUNCj4gPj4+PiBzdWJzeXN0ZW1zLiBD
b3VudGVyIGdvZXMgdG8gY291bnRlciwgdGltZXIgdG8gdGltZXIsIFBXTSB0byBwd20uDQo+ID4+
Pg0KPiA+Pj4gSG93IGRvIHlvdSBpbnN0YW50aWF0ZSB0aGVzZSBkcml2ZXJzIHdpdGggYSBzaW5n
bGUgY29tcGF0aWJsZQ0KPiA+PiAicmVuZXNhcyxyei1tdHUzIj8NCj4gPj4+IElmIGl0IGlzIHNl
cGFyYXRlIGRyaXZlcnMuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBXaXRoIE1GRCBmcmFtZXdvcmsgYW5k
IG1mZF9jZWxsLCBqdXN0IGxpa2UgbWFueSwgbWFueSBvdGhlcg0KPiBkcml2ZXJzLg0KPiA+DQo+
ID4gVGhleSBhbGwgaGF2ZSBjb21wYXRpYmxlcyBmb3IgY2hpbGQgZGV2aWNlcywgcmlnaHQ/Pw0K
PiANCj4gTm8NCj4gDQo+ID4gQ2FuIHlvdSBwbGVhc2UgUHJvdmlkZSBhbiBNRkQgZXhhbXBsZSB3
aGljaCBoYXMgYSBzaW5nbGUgY29tcGF0aWJsZQ0KPiA+IGFuZCBNdWx0aXBsZSBjaGlsZCBkZXZp
Y2VzIGluIGRpZmZlcmVudCBzdWJzeXN0ZW1zPz8NCj4gDQo+IFRoZXJlIGlzIHBsZW50eSBvZiBl
eGFtcGxlczoNCj4gZ2l0IGdyZXAgLUMgNCAnc3RydWN0IG1mZF9jZWxsJw0KPiANCj4gRXZlbiB0
aGUgZmlyc3Qgc2VhcmNoIHJlc3VsdCBpbiBNRkQgZGlyZWN0b3J5IGZpdHMgeW91ciBuZWVkcywg
ZG9lc24ndA0KPiBpdD8NCg0KVGhhbmtzIGZvciB0aGUgcG9pbnRlci4gV2lsbCBzZW5kIG5leHQg
dmVyc2lvbiBiYXNlZCBvbiB0aGlzLg0KDQpDaGVlcnMsDQpCaWp1DQo=
