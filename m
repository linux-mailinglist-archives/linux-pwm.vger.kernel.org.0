Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895564B791
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 15:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiLMOi4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Dec 2022 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiLMOiz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 09:38:55 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA881E700;
        Tue, 13 Dec 2022 06:38:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkqrbROUxCEqo52hc7UfYNZUBgxfoVcFhDGrEfCTn9fNJuFFlZrapIxF8fiHUFR677eJkhmuzUOa+rtCg1g599k0Nn90vpcdLHlKRlnS3+ZO79WlgTDk4th4IrRPLDmB4S3da92e2YuPM2tRmFOauWZYz/aBMb3JmVQhjhK1NceePiKbXZN7MghqbR+a8z5ITuGQ/j1nOFJaiu0PZuWs/Y5dRVMkYWBCcihTSWdNYUsNkwxh56Dz0YpBjn84fX32iqVWnodUVHPRm1tg6EPRAmkwTkHmVvHRuIDDRjpJUxBHChr2E+t4KFP8ywy6QSHy07zN/6sGgaLuMit60quB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJRIvek0cjLFCHStNN/xye/0VoqRsX1COecJqJyJCZ8=;
 b=eUQlNZ7DdXKd2t6/JRDnmxgnnV6VNXW3AGZ1Fn4Uo45MMHDajBBsxWD7LxAIDV+KBHFAmH+zlARSqY8BBgDv+C6WduoRzaylOUQ+vTduypqBgt7KqJrdSZbyc9Itpps9UXRKMuKXMtfLOiVjDUGlExofrJhu78nSZPkC3k8bOSuUkfWHOM3VPoOA0g6Fy9QsxMFgLCjVPG3O8lgrjc6T69AaVuBJJjxNlmIZxWtbTD5I0+hJ0ZJgioIAEPqbXBAgc+LbeZ4f+3Sop1kCPqLBplK7SEyc/bIbhZuMBQqtgD28rWcYfHmugKqX9UHq7ZNHG/qB/s3zJdgIuljVbcPtFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJRIvek0cjLFCHStNN/xye/0VoqRsX1COecJqJyJCZ8=;
 b=vjfAHafD/6hsnK0vGP5QPE+YUUvx+nuTuVhYYiVk2D2xYAc6P9bI+yAgYBUJ868jtMQ3X5uMDGDNeLDqx4Aq9X0nuODPNmkTaAavvZR4rYlbytr40cr5Wxy/XW/BKVN0iXkp9wCnUw5oT1FnanVT3xe06F8imsASNrRyXQQCB0E=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9827.jpnprd01.prod.outlook.com (2603:1096:400:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:38:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:38:52 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v2 3/5] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHZADlUR95R97/2DkGwH5TaLScgW65r+zCAgAAFIjA=
Date:   Tue, 13 Dec 2022 14:38:52 +0000
Message-ID: <OS0PR01MB592286BA710CAEB5051778DF86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221124191643.3193423-1-biju.das.jz@bp.renesas.com>
 <20221124191643.3193423-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdVTq5zgJL40Dbisw0as7ei0c+asHABMU=8tBEpTR+2YfA@mail.gmail.com>
In-Reply-To: <CAMuHMdVTq5zgJL40Dbisw0as7ei0c+asHABMU=8tBEpTR+2YfA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9827:EE_
x-ms-office365-filtering-correlation-id: dff600b9-735a-431b-394c-08dadd17c143
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7ZOS0EL33Hac3eGoUPtA/myzbF++8DlWnfBGlFn/Y0SzOwNdAO94AFQlTavxQl15EvC/b6H9ZkzZWKcl1qNxXjqFaPm229Vxm34IM6arorpgO6CUf1DGTxsljjaAmce6THiWtxHuqSNUQPOv2AhsUZh4tRGIfC+sfBUl4Xj9KlqHIFgr1Eww2ZLZmQcn/x7Hi+8C1gHR8o2n29euWDVS2rRb+xfmW02tzZCRrf7S2ZyqkQ7jmmSVbiQg01q/7MtcvzrgmTYHCdMJoovvrKVP25nAQ7KD6kORRQhTiIeO5lwITajYNx0lM0BjFu56axn3zkaD7JUJYwiraV1zjsgY/qWNBEtmNwzeKNT40K/Y7HFZsF+Agl7RgU2WbEVEwlmOS4nAKotuMqG5G8nRlf+YbhYJHM/w4NEfDy+K4kRWNhjXDGXacpFADzi08XWXTKLCPCRoNxWHLV5Sy2riMnhjUO0ANEIyTR91E16juJyF4nqkVKERvHcfJWEpMQEw8TR0t2EZ+RL1okMLviVwGfv4t8ou57nk+qyZhSmFLl0MkVvHMOosNAdGTfnmy2nQG7vUbJmpee5cZFRpgLilyKQTKATT+/bXdJXlzcQpdwvaM01gvh7Cag/U2oTOK1NbTetdgRwdHXsP6E+9BJQCyUWDIPCAY5AnaYNilD/W1pjZh0lCNxrgd6sLZTR0RiBu7jH2UfRbV1j4rD/3AuIOOajnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(71200400001)(478600001)(38100700002)(41300700001)(122000001)(86362001)(53546011)(66446008)(26005)(6506007)(7696005)(9686003)(186003)(64756008)(76116006)(5660300002)(66476007)(8676002)(66946007)(38070700005)(33656002)(55016003)(2906002)(66556008)(83380400001)(6916009)(54906003)(4326008)(52536014)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amRvc0czQnVVYXBmbzVhanJtV0poREJncnN3RTM0VWtYMjlvd05HRlJHUGFQ?=
 =?utf-8?B?dWpDTjJRZnNDVy9HMmlGWFJOTko3a1pmT3VBRzA2dHpzZnQ3UDNsRm9rekQ3?=
 =?utf-8?B?TmN6UVJwcStKOVRVTWVPTkJraHZqeVZYQlo5cjZXQkdlOE5iVGtsKzZURmRy?=
 =?utf-8?B?OFVXSlBiUE1menI5Q1NtRVdsQStvUS9INWpydlRuaXNVcGJYOVY5Ly92b0U1?=
 =?utf-8?B?UDF3Slo1eDdQd0RpYi9SQ3VlNy9Zbk9XTXBPcW1JVGJHYURkUDhwTWNzQUFw?=
 =?utf-8?B?eXQvYmVGdWpGZDAwQzB3NXdPeXNjU3VvTTBLdFdUU0FFQ2lnVHZJNUpSc3dY?=
 =?utf-8?B?amM1alJkVGNTNVhHWDcrQm1QVHdWakRoZ1NlUnZiY01ZSVJod2Mva0J4c3BU?=
 =?utf-8?B?eG5ZK2hiZ0t2VFBQRCtxTFp1L3pROWo1ZEwvblFLMDVrSGxpQklkQVYwRmF4?=
 =?utf-8?B?R05SQ1pnREM4K1B3czgvbUZGWDZuY3BXTHkxZ1g2RjkwZ1dxakd6aXlDSHJj?=
 =?utf-8?B?TmRoN2JrQm5GN05oa0licEVhQ1RrOENNRVg4UVFETzNwWjkvWm9xMDJvbTIv?=
 =?utf-8?B?b2pRWlYyWTdhSFNrNDYyWnEvWE5jMGZBUTRiWkZuK1hzRWF2bnhkWnlyNXV5?=
 =?utf-8?B?c2ZBMTRhcm8ydCs5NGxUQ2szUnVwYjVGbmVwNkd4OUJzUXp3eTBHU2Y3dTkw?=
 =?utf-8?B?ZWZLV0dQR2NLeFBrTFpDa1MrWWNnTUJ2UDZGSWpVUXc0U2o4eDBkMEpKUlpV?=
 =?utf-8?B?VzdkeUZGYm9LQkluOGJvS2dHaHBiV1p1Nmltb1V0NG1qbnViVXJpSWpiUGhp?=
 =?utf-8?B?RDA2TUlxblhLYmlWTmhJN0ZCUmwwS2VKNHNBdlNVSCs1UkxReG9OYU5BK1M0?=
 =?utf-8?B?YSt4MVh4QUtsNzloZ1RmYkxoL0FFRFZkSndBVzZFUmVMOGtMR2hoZWcxWVl6?=
 =?utf-8?B?NnJZemttMGhZWHpYNHRaV1k3a1l4RkVrTlRyby9Xem5UeDY1QkRYOEF2V28w?=
 =?utf-8?B?a3NNbEx0MzBRT3c1TUlaU0xVc2lERnM0MGY2aUdIa1BrdVJVR2ovN2NTSFJF?=
 =?utf-8?B?ZExjek1abEV5eFk5VXpwL3J0WHUyVTRQdUNnOTBFL0dLSjhFT2laZ1pKZHJE?=
 =?utf-8?B?bDdHajk3a01ESjN4a3NnNUMwTHNwdlplZGNRT08vWFdRSWk1MTczUUtDRXRa?=
 =?utf-8?B?bDVxWTIydE50WnRVMWtzc2daWVpNdlV0Zkduamd1eEZpd0tKRmU2RjgyM05S?=
 =?utf-8?B?OXFrTmNVak15SGVmV3pQYkJpOG5KRDZwcWQ5dTNCUHhxaXVJNFRyYVVCYVg3?=
 =?utf-8?B?aThIWXFVdzUxVkJPeUpZa0VIdUcyODc3cWVxUlZQc0tMRlVDSk4xTis4dkpR?=
 =?utf-8?B?NGdNeTBUaExLcmhEb2E1dW5IZDM5RVFRbGhQaEdGeFVTY09qUjZIdGlBZlpk?=
 =?utf-8?B?d1JaS0pmMkZnQ2tQQVc1RmpKUDFCQmphUW9aemlnSDFCbnJpaHFiSWRyVjRZ?=
 =?utf-8?B?SFhjNE9SQXQ3RCtncktEWDJJRElwTlNJVVI5RE9uNGhtc2RzMVN1MjhLUktt?=
 =?utf-8?B?TkdMWFYvUWNsV3JOelkwOTREdTFQbGV0UmlJd2hnZmFLUGs0Y21nZVBTN2g3?=
 =?utf-8?B?dmwyTUhHMm1od1lkSy9MNWRBMkptMmptZXplSmtydXc4T2oyTUxZa05ONlc5?=
 =?utf-8?B?TXllb2lSbXR5NE1LZ2hyeVpHaThwQWU2eFNxcGo2OFRkRlN4SVN6blp6RFda?=
 =?utf-8?B?MlNWK3dpNXd4ZGdzNGJJUEV0VFN3R2VHOEJabnBETURLWmg5dUR5YWJkVTNU?=
 =?utf-8?B?aC9xL1JENlZ4eFc1dXBWN0tOMmV1RmZqV3FyaWhQNnMwaTZ2NjA4d1NiNXp0?=
 =?utf-8?B?Y2EzMlpNS3lRVkdNTGVoSFpPcWlEc1FJR3BRZFFFdVAzOGRJTDBDS1Nyd0pM?=
 =?utf-8?B?TndTYWNhenZ5alVWM1Roc2NMOERscGZZTmswL213T3V3VGFFQkw2STk5V0pH?=
 =?utf-8?B?UDNKY2VlT2ROcHpKWVVyaEtRbXdaUjEzcmdSa2F2RUlONGVRcVFENFhFTnJz?=
 =?utf-8?B?WXd2cWhSeXVFUHlOWkQxZG4yaHZoTFVkM0haWXIzdXNsQUxUM0NKN3FBTTFI?=
 =?utf-8?B?UUJuUndEWE5EVDRxQTAvWUFvSm5KVUtwcmthK2RoZkxsQU0vRktaMVhQTU1p?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff600b9-735a-431b-394c-08dadd17c143
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:38:52.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4U7w7sp4e0YJXcG8rA6zBT93v8uslE/IAD5dWfJaPLu1Rs1K8g6zobCoQy4R6n3DSEgW9SmIO8DKz2T4NK2pPwqeqgQ7FdMyLIK181neU0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9827
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIHB3bTogQWRkIHN1cHBv
cnQgZm9yIFJaL1YyTSBQV00gZHJpdmVyDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCBO
b3YgMjQsIDIwMjIgYXQgODoxNyBQTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+DQo+IHdyb3RlOg0KPiA+IFRoZSBSWi9WMntNLCBNQX0gUFdNIFRpbWVyIHN1cHBvcnRzIHRo
ZSBmb2xsb3dpbmcgZnVuY3Rpb25zOg0KPiA+DQo+ID4gICogVGhlIFBXTSBoYXMgMjQtYml0IGNv
dW50ZXJzIHdoaWNoIG9wZXJhdGUgYXQgUFdNX0NMSyAoNDggTUh6KS4NCj4gPiAgKiBUaGUgZnJl
cXVlbmN5IGRpdmlzaW9uIHJhdGlvIGZvciBpbnRlcm5hbCBjb3VudGVyIG9wZXJhdGlvbiBpcw0K
PiA+ICAgIHNlbGVjdGFibGUgYXMgUFdNX0NMSyBkaXZpZGVkIGJ5IDEsIDE2LCAyNTYsIG9yIDIw
NDguDQo+ID4gICogVGhlIHBlcmlvZCBhcyB3ZWxsIGFzIHRoZSBkdXR5IGN5Y2xlIGlzIGFkanVz
dGFibGUuDQo+ID4gICogVGhlIGxvdy1sZXZlbCBhbmQgaGlnaC1sZXZlbCBvcmRlciBvZiB0aGUg
UFdNIHNpZ25hbHMgY2FuIGJlDQo+ID4gICAgaW52ZXJ0ZWQuDQo+ID4gICogVGhlIGR1dHkgY3lj
bGUgb2YgdGhlIFBXTSBzaWduYWwgaXMgc2VsZWN0YWJsZSBpbiB0aGUgcmFuZ2UgZnJvbQ0KPiA+
ICAgIDAgdG8gMTAwJS4NCj4gPiAgKiBUaGUgbWluaW11bSByZXNvbHV0aW9uIGlzIDIwLjgzIG5z
Lg0KPiA+ICAqIFRocmVlIGludGVycnVwdCBzb3VyY2VzOiBSaXNpbmcgYW5kIGZhbGxpbmcgZWRn
ZXMgb2YgdGhlIFBXTSBzaWduYWwNCj4gPiAgICBhbmQgY2xlYXJpbmcgb2YgdGhlIGNvdW50ZXIN
Cj4gPiAgKiBDb3VudGVyIG9wZXJhdGlvbiBhbmQgdGhlIGJ1cyBpbnRlcmZhY2UgYXJlIGFzeW5j
aHJvbm91cyBhbmQgYm90aA0KPiA+ICAgIGNhbiBvcGVyYXRlIGluZGVwZW5kZW50bHkgb2YgdGhl
IG1hZ25pdHVkZSByZWxhdGlvbnNoaXAgb2YgdGhlDQo+ID4gICAgcmVzcGVjdGl2ZSBjbG9jayBw
ZXJpb2RzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYxLT52MjoNCj4gPiAgKiBSZXBsYWNlZA0KPiA+
IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfc2hhcmVkLT5kZXZtX3Jlc2V0X2NvbnRy
b2xfZ2V0X3NoYXJlZA0KPiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiANCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLXJ6djJtLmMNCj4gDQo+ID4gK3N0
YXRpYyB2b2lkIHJ6djJtX3B3bV9nZXRfc3RhdGUoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1
Y3QNCj4gcHdtX2RldmljZSAqcHdtLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHB3bV9zdGF0ZSAqc3RhdGUpIHsNCj4gDQo+IEFzIG9mIGNvbW1pdCA2YzQ1MmNm
Zjc5ZjhiZjFjICgicHdtOiBNYWtlIC5nZXRfc3RhdGUoKSBjYWxsYmFjayByZXR1cm4gYW4NCj4g
ZXJyb3IgY29kZSIpIGluIHB3bS9mb3ItbmV4dCwgdGhpcyBuZWVkcyB0byByZXR1cm4gYW4gZXJy
b3IgY29kZSAoYnV0IHlvdQ0KPiBwcm9iYWJseSBhbHJlYWR5IGtub3cpLg0KDQpUaGFua3MgZm9y
IHRoZSBwb2ludGVyLg0KDQpPb3BzLCBNaXNzZWQgaXQuIFdpbGwgcmV0dXJuIGFuIGVycm9yIGNv
ZGUuDQoNCkNoZWVycywNCkJpanUNCg==
