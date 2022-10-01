Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5035F1EFE
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJAT0r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAT0q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 15:26:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8314BA5F;
        Sat,  1 Oct 2022 12:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqrEZyfy9V/ZPU8I9PoIYtTVVjJA/AqEQ+o4Ekcr/Ih87IKahkBzEz7HnpufckaglFGI3ocAGfcZuzXUTon0nxao9tI4bxMoJRrzO4ckGxaXvOkMvE9zorAJhjF0z2kf6V/ns33CXaUEvLlOa1pSos30K4EKo05U2rr4i99McXaePu9SU1PUR2yp+G2E0dtjrvR4Ld5OItx2vyQSuZbcjImG3cFJGRVUGZUGYmhw/VkLgLKHBx6Z0mAevRNSF8laQlG5nmqVHp6VtNwv+Hoh1ep4PmCmJlTl95J7WdihlejDsVKQiCRsF2tLnEqxjT345KJxhDH+R8jG9BQN1+6lAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BquaDPGhOA8cHI9aq/oLMw9LzganBRnnegXMSUMq7Ww=;
 b=S3wfVMBjxdCnYcMdYU1AE4494+j1GKVW612QzAbAHC5cTHDWFIQZiZ1Yq3ZS4TD0GEZBUauJGGyKYeHV80fZKOGAP7kkvVUoXEaLvgdsnP+qlsPvWRUxofg9cexmo+dH1gk1kGzCthcQqdKFi7TtKEdQYHf4WRaQn7qRf9QpXX13nZSYRE1c4bfqQGpHamkP/4U/2BnDJgTdygCGLQhbQtAli6ZqS7gErOOflryrZji/0z0NI/zA2Jsqfl9K8nqAbG7tbA7Iboe91O674ZpHh6mBhfEOD2lML5OFrk8qTnYxkG2UG0/P1a/rj2kbbBaw71qnjGlwlAvq5K305Gb8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BquaDPGhOA8cHI9aq/oLMw9LzganBRnnegXMSUMq7Ww=;
 b=BxTer+9lfEKA33Gf0sAfggbJ2qKLS7UvkC80mv5xqSz93jHKXViW8c7tx6WRGx+BDGJTIQIX9NTWUXUeqeIzMIcEAFyd/UCaS/19Tnxpwle6v5kvJPVI2vJyQNeZr3tf/tYa0XIQNqSNSrImfDekJbv4y9m5OTo27bOX7hJzpZE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8749.jpnprd01.prod.outlook.com (2603:1096:604:157::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 19:26:41 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 19:26:41 +0000
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
Thread-Index: AQHY0+6TADmAt9m0c0u1ieTfUadBoq32sJKAgAABH3CAATHPgIACC6Ng
Date:   Sat, 1 Oct 2022 19:26:41 +0000
Message-ID: <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzbcyxY839GlR71V@google.com>
In-Reply-To: <YzbcyxY839GlR71V@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8749:EE_
x-ms-office365-filtering-correlation-id: 05e3a0d2-bb2f-4301-59c2-08daa3e2de2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKSF1b26ExubJVytp/+TRBaWMBy91o7E1iw2AqpGJEjLSDYZUKYwaKQMo+zsK9f4WD4mdTl4NQExnjQXjldV+Iwm/SLG1XmClm5BpNlnvOr9X9NuIXG96v30bztXCCTvhGmACRaZVkNfsTkginQEzJn6+Hi2U17QPpIhzNbzTI6KXmrzUXTVVToTMB6H9RlNmjDjD4dY2PbbeAlnqj1hQfVv9dKA+hDVl4OxordyhjbIJCy44aigeYfEiQyBtQlJhH/HOewMolKy+umJI3u7D7oEcbNWL2DKySWZ9c3uIp2sVht1foMHoPqLt51soQJBFiHKx9OsA8pLpgJB6O7wxNg3RD3zzNKK4KsFJJxdiArIwWCDru/OqLzG1Tgz8PrryJ2P4NjY6ATg6rFgfhxIx6v0fSfObpEkiprTwXT6PHBKotd0dPRIRCPNQk56MFeikdSNwbVx3rJer/jeULo0XBloRjvFlJGsI/GOXWR1pmFrz9dItoU2fIwGHEIziP7mMWUB02epv97AdPPGpyBl4qfljC2eZ6ynHXGVFNHVvftAP8akrqlUGhMW1vNT1a1/s6hJLx8KqFd9hY/OkB712CG9BLn0fHtFw+g8vnyWCKBKvDU3t5ZgHbGl0WkoFy8y4NWNlVcmORVIFWfOriP7IgMz8CoAiB4zimBD8wKkZrKglB9Hm5Ze2QPd44A3KaeBp5oDrrO4VSGG7MPlfNJXUUa4Mk6Ylz+ZPZIZym6QnqMNciX/R2AFbvRhR4Z5pINNKi7RT89UAXr1xv8ue6hggw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(2906002)(8936002)(41300700001)(54906003)(6916009)(86362001)(316002)(66946007)(66476007)(4326008)(76116006)(66556008)(64756008)(66446008)(38070700005)(8676002)(186003)(71200400001)(478600001)(9686003)(7696005)(33656002)(6506007)(122000001)(5660300002)(52536014)(55016003)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2JDQzI1TFNVY1BlUGV1Ky9SZ3RqSk5RSDQ0RzcyditpSmR6N2VqTkpsRTJH?=
 =?utf-8?B?UmhpOGpvc1FHbnZ3cWhtRFNUbDhNN2VsVTEyZFE2eE1GZ1FTYTM0cTdkRk1N?=
 =?utf-8?B?MWdwTTBSYjhPQ1o0Yzl1clZsclZUTVhCZkpwaTNFaGx4TW1NeTFzY3RQU0JH?=
 =?utf-8?B?OGVmdnlzc3FjS1l5Yk1Oa0hZdzd0VWhiMHRTZ3lJa1psWTRHdWtFcW9oSE9r?=
 =?utf-8?B?bXJyd3IrRlFBeE95ZmxNc0lOdnBWMDVtR2pSQTJsRnRqVnVtZW53YVN3SFhV?=
 =?utf-8?B?cFRlRTdUOG1sVEpuNXVYQk9uQjVsVFc4cTd5b2Y0ZXM5MFM3RFdaUmswTTdC?=
 =?utf-8?B?N2ZsRVgzMm9ESkVPWWNTblhZUmJvRUpFNDZvZzZxL2xmUE9yRnVCYUVZYi8x?=
 =?utf-8?B?L1dldDJlVzhiSlVKU1hZWTYwczlrYWJjekcwOHRrTHJxdmNiMC9iZW9OYjhD?=
 =?utf-8?B?RndLZWNzbXIySXc1K0pibEhiaFNlOXFrMW9RcEUrNXc1SWZvWEtoZ3Rna1BX?=
 =?utf-8?B?Um9BYk9VRWVqWmczUEhpTUdpMmNQd1IxbmRXOFFha1k1MzZ2VGw2Rzk1Z1Zw?=
 =?utf-8?B?UURLeWtCSWxiSDY3eGtNbk1ocUxadWZoUlMxeFRqVDlpMDhIeGdmMkh0ZGda?=
 =?utf-8?B?Uytwek4rWFlwM0RsblFldTdDR3UyZGdINHpJUXRyaitGS2FrbjNTY2w5OHM3?=
 =?utf-8?B?MUVlUVNYd2thNitYaDR5N0doek1QVk1qdEorM3Y0U0tFbVdEYllLYTN4alpL?=
 =?utf-8?B?TkNFOWtxbGkwbVZGUlMwa05ZU2NMeXJoa3lZcjlkZkFlcnlhY2ZyakszVmVX?=
 =?utf-8?B?bkd4WHFQMkkrSWU3ZVNXRHlHVytkb3p4U2tLRG1ycEt0TVhEdUNpNmRhK2ZX?=
 =?utf-8?B?QXNuckE4eFgranphcElnZUxzUkdMYk1sRWlxLy9YZVUzcVlNWkE0L1dHMHBR?=
 =?utf-8?B?NlJ2b0pCNTJBbnJ5MUhCOW9pNHZVcUtLdWJvV2tocjZxRlVTQVpPdUNvbDhs?=
 =?utf-8?B?dzQrRGQwS3BCZG5hTkdNaUNaVm9YUENvVFpoaFRQdi9ZKzBtRm96bjJMMHVy?=
 =?utf-8?B?M0pUTlpWWG9vMFM0OVlHWWZreEM0SUhYRVk4SkZWUTM5YzJpVGJNTFc0YVRG?=
 =?utf-8?B?TzMwZDVDd1lIaXNGZW5YTGRFRGgwRFJtdkZucmhKWlVzZ3lIQVlrclpXbGVE?=
 =?utf-8?B?a0JrUGdQSjhLckZpc2o4RVh5M2F1anQwQW9CQy93ajZDMHA0MkZ6bVZEY1R3?=
 =?utf-8?B?SE5zdDIvdmFpWGIwa1B6NUJVM01xa3pFaG1JTVQ0OTl5bjU3aWZ3WW40ajBF?=
 =?utf-8?B?V2pKK3BoUmd1M0FGakg1QzV3WVF1KzRWYVl0eWVYU3dsRURNZzgrd3Jvb3Qz?=
 =?utf-8?B?MmpxOFJGclQxZW9NYlB6MDV2NWwxNDN2d241RkVEWk9NSGJ3ZU5lU1FabFpw?=
 =?utf-8?B?R3hkb1MycXZEa1NXRlRreUFwYkIzTUVLcTZTKzdnSmR0QThjeWhnZmU2TXho?=
 =?utf-8?B?MEl0aktCazA3MVBzakdzSVozNitnYTBFOUc2eC9vWHhOdC9XQW56QmFaaWlx?=
 =?utf-8?B?S05VQzhQREFCUFRoNGU0ejVUOGpBZW4yUGczS3Z6ZU9rVjdJeWFiMXROMU1w?=
 =?utf-8?B?dy9vOTZCekgrVC9vMzd2U1pJRWlFQUFiUHdoa2pvdzdMK05zNmRSZDFSZ2Iw?=
 =?utf-8?B?OGdpY0txb3JEZ0dXRy8yYlBVd05sKzVaLzJLaHZqK25VMSt5bG1FaTdZSEhk?=
 =?utf-8?B?OElsOG9ReEFPTXBPbHNaOFVtOHdEbDd1RkY5VTRpbGhXNVR6a1RDeldlL25n?=
 =?utf-8?B?QVR5YW1vdDNRWFkyTEZMazZxRGtFamVWVGpybS9rSUhsSnoxRmNKcEFWNHg3?=
 =?utf-8?B?M1dUMUx1ZEx3UGNrcm1SNzdzL2ZYclZzL1UxSlkwbU91Q0JGNGV2MFRKbUYx?=
 =?utf-8?B?enJFb1I2TlF2NURGYVI4OFdoV1haeVVZa0FNcms2UkYvZ3M1bnhmYS8rUUpx?=
 =?utf-8?B?QjRTVWMya2gyNzA0YmtNb1pUSzN4SU1SMDZ2SHVSdnlhUTh1eStZK2hURkdy?=
 =?utf-8?B?MkhvbGx0ZWRiZnVsd3FWSDRkRXVaVkxPUFJYaEFBc0RwbmN4UWhvMmVPQkZy?=
 =?utf-8?Q?utwJo7BfohA/p4QA6usgGa1X0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e3a0d2-bb2f-4301-59c2-08daa3e2de2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 19:26:41.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fc55O32/55mmSyi1ckfCu/xKjA2Hv6ulGoFZ+2ZwWT0ddPIf3Zunu6YZA9jT136gsD7I6iz9dUZr+gK3DpJ6t1ujawuQyVEmNEwBdfdDawM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8749
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGVlIEpvbmVzLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDMvN10gZHQtYmluZGlu
Z3M6IG1mZDogcnotbXR1MzogRG9jdW1lbnQNCj4gUlovRzJMIE1UVTMgUFdNDQo+IA0KPiBPbiBU
aHUsIDI5IFNlcCAyMDIyLCBCaWp1IERhcyB3cm90ZToNCj4gDQo+ID4gSGkgTGVlIEpvbmVzLA0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggUkZDIDMvN10gZHQtYmluZGluZ3M6IG1mZDogcnotbXR1MzogRG9jdW1lbnQNCj4g
PiA+IFJaL0cyTCBNVFUzIFBXTQ0KPiA+ID4NCj4gPiA+IE9uIFRodSwgMjkgU2VwIDIwMjIsIEJp
anUgRGFzIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRG9jdW1lbnQgUlovRzJMIE1UVTMgUFdNIHN1
cHBvcnQuIEl0IHN1cHBvcnRzIGZvbGxvd2luZyBwd20NCj4gbW9kZXMuDQo+ID4gPiA+IAkxKSBQ
V00gbW9kZSAxDQo+ID4gPiA+IAkyKSBQV00gbW9kZSAyDQo+ID4gPiA+IAkzKSBSZXNldC1zeW5j
aHJvbml6ZWQgUFdNIG1vZGUNCj4gPiA+ID4gCTQpIENvbXBsZW1lbnRhcnkgUFdNIG1vZGUgMSAo
dHJhbnNmZXIgYXQgY3Jlc3QpDQo+ID4gPiA+IAk1KSBDb21wbGVtZW50YXJ5IFBXTSBtb2RlIDIg
KHRyYW5zZmVyIGF0IHRyb3VnaCkNCj4gPiA+ID4gCTYpIENvbXBsZW1lbnRhcnkgUFdNIG1vZGUg
MyAodHJhbnNmZXIgYXQgY3Jlc3QgYW5kIHRyb3VnaCkNCj4gPiA+DQo+ID4gPiBTaG91bGRuJ3Qg
YWxsIHRoaXMgZ28gaW4gdGhlIFBXTSBkcml2ZXIgYmluZGluZz8NCj4gPg0KPiA+IExvb2tzIGxp
a2UgYXQgdG9wIGxldmVsIE1UVTMgSVAgcHJvdmlkZXMgc2ltaWxhciBIVyBmdW5jdGlvbmFsaXR5
DQo+IGxpa2UNCj4gPiBiZWxvdyBiaW5kaW5nIFsxXSwgd2hlcmUgdGhlcmUgaXMgYSBjb3JlIE1G
RCBkcml2ZXIgYW5kIHB3bSwgY291bnRlcg0KPiA+IGFuZCB0aW1lciBhcyBjaGlsZCBkZXZpY2Vz
Lg0KPiANCj4gUHJldmlvdXMgbWlzdGFrZXMgYXJlIG5vdCBnb29kIHJlZmVyZW5jZXMgZm9yIHdo
YXQgc2hvdWxkIGhhcHBlbiBpbg0KPiB0aGUgcHJlc2VudCBhbmQgdGhlIGZ1dHVyZS4gPTspDQoN
CldoeSBkbyB5b3UgdGhpbmsgdGhhdCByZWZlcmVuY2UgaXMgbm90IGEgZ29vZCBvbmU/IEkgYmVs
aWV2ZSB0aGVyZQ0Kc2hvdWxkIGJlIHNvbWUgcmVhc29uIGZvciBpdC4NCg0KQ2hlZXJzLA0KQmlq
dQ0KDQo+IA0KPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9iaW5kaW5ncy9t
ZmQvcmVuZXNhcyxyemcybC1tdHUzLnlhbWwgICAgICB8IDUwDQo+ID4gPiArKysrKysrKysrKysr
KysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0DQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9yZW5lc2FzLHJ6ZzJsLQ0KPiA+ID4gbXR1My55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yZW5lc2FzLHJ6ZzJsLQ0KPiA+ID4gbXR1My55YW1sDQo+
ID4gPiA+IGluZGV4IGM0YmNmMjg2MjNkNi4uMzYyZmVkZjViZWRiIDEwMDY0NA0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JlbmVz
YXMscnpnMmwtbXR1My55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvcmVuZXNhcyxyemcybC0NCj4gbXR1My55YW0NCj4gPiA+ID4gKysrIGwN
Cj4gPiA+ID4gQEAgLTIyMyw2ICsyMjMsNTAgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPiA+
ICAgICAgICAtIGNvbXBhdGlibGUNCj4gPiA+ID4gICAgICAgIC0gcmVnDQo+ID4gPiA+DQo+ID4g
PiA+ICsgICJecHdtQChbMC00XXxbNi03XSkrJCI6DQo+ID4gPiA+ICsgICAgdHlwZTogb2JqZWN0
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICAgICAgY29t
cGF0aWJsZToNCj4gPiA+ID4gKyAgICAgICAgY29uc3Q6IHJlbmVzYXMscnotbXR1My1wd20NCj4g
PiA+ID4gKw0KPiA+ID4gPiArICAgICAgcmVnOg0KPiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlv
bjogSWRlbnRpZnkgcHdtIGNoYW5uZWxzLg0KPiA+ID4gPiArICAgICAgICBpdGVtczoNCj4gPiA+
ID4gKyAgICAgICAgICBlbnVtOiBbIDAsIDEsIDIsIDMsIDQsIDYsIDcgXQ0KPiA+ID4gPiArDQo+
ID4gPiA+ICsgICAgICAiI3B3bS1jZWxscyI6DQo+ID4gPiA+ICsgICAgICAgIGNvbnN0OiAyDQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgIHJlbmVzYXMscHdtLW1vZGUxOg0KPiA+ID4gPiArICAg
ICAgICB0eXBlOiBib29sZWFuDQo+ID4gPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBFbmFibGUg
UFdNIG1vZGUgMS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgcmVuZXNhcyxwd20tbW9kZTI6
DQo+ID4gPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiA+ID4gKyAgICAgICAgZGVzY3Jp
cHRpb246IEVuYWJsZSBQV00gbW9kZSAyLg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICByZW5l
c2FzLHJlc2V0LXN5bmNocm9uaXplZC1wd20tbW9kZToNCj4gPiA+ID4gKyAgICAgICAgdHlwZTog
Ym9vbGVhbg0KPiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogRW5hYmxlIFJlc2V0LXN5bmNo
cm9uaXplZCBQV00gbW9kZS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgcmVuZXNhcyxjb21w
bGVtZW50YXJ5LXB3bS1tb2RlMToNCj4gPiA+ID4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+
ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogQ29tcGxlbWVudGFyeSBQV00gbW9kZSAxICh0cmFu
c2ZlciBhdA0KPiBjcmVzdCkuDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgIHJlbmVzYXMsY29t
cGxlbWVudGFyeS1wd20tbW9kZTI6DQo+ID4gPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4g
PiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IENvbXBsZW1lbnRhcnkgUFdNIG1vZGUgMiAodHJh
bnNmZXIgYXQNCj4gdHJvdWdoKS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgcmVuZXNhcyxj
b21wbGVtZW50YXJ5LXB3bS1tb2RlMzoNCj4gPiA+ID4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0K
PiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogQ29tcGxlbWVudGFyeSBQV00gbW9kZSAzICh0
cmFuc2ZlciBhdA0KPiBjcmVzdA0KPiA+ID4gYW5kIHRyb3VnaCkuDQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgICByZXF1aXJlZDoNCj4gPiA+ID4gKyAgICAgIC0gY29tcGF0aWJsZQ0KPiA+ID4gPiAr
ICAgICAgLSByZWcNCj4gPiA+ID4gKyAgICAgIC0gIiNwd20tY2VsbHMiDQo+ID4gPiA+ICsNCj4g
PiA+ID4gIHJlcXVpcmVkOg0KPiA+ID4gPiAgICAtIGNvbXBhdGlibGUNCj4gPiA+ID4gICAgLSBy
ZWcNCj4gPiA+ID4gQEAgLTMwNSw2ICszNDksMTIgQEAgZXhhbXBsZXM6DQo+ID4gPiA+ICAgICAg
ICAgIGNvbXBhdGlibGUgPSAicmVuZXNhcyxyemcybC1tdHUzLWNvdW50ZXIiOw0KPiA+ID4gPiAg
ICAgICAgICByZWcgPSA8MT47DQo+ID4gPiA+ICAgICAgICB9Ow0KPiA+ID4gPiArICAgICAgcHdt
QDMgew0KPiA+ID4gPiArICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMscnotbXR1My1wd20i
Ow0KPiA+ID4gPiArICAgICAgICByZWcgPSA8Mz47DQo+ID4gPiA+ICsgICAgICAgICNwd20tY2Vs
bHMgPSA8Mj47DQo+ID4gPiA+ICsgICAgICAgIHJlbmVzYXMscHdtLW1vZGUxOw0KPiA+ID4gPiAr
ICAgICAgfTsNCj4gPiA+ID4gICAgICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAgLi4uDQo+ID4gPg0K
PiANCj4gLS0NCj4gTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQo=
