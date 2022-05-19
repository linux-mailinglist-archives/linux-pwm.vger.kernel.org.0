Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDA52CF67
	for <lists+linux-pwm@lfdr.de>; Thu, 19 May 2022 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiESJa0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 May 2022 05:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiESJaY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 May 2022 05:30:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACA65429;
        Thu, 19 May 2022 02:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv4EboN8a55jOgfVmyfAgn3DPrCvAWKtAyUPl3+MgKTLTSH/aPfxe/wBWeoqnop9+2/s/cZ1/ap1Th+avIspCfHKSRkiGjqKF0vtezBwUvFQw9RZV0ZVN+J3MEWhAwBdORdU/cW2bGEg4I04nwAJVURUTzZEQB6Ljnb4iRy+RvOyO5XYXYBhTRatX8BlC8FqqvsnMWSsQUZBmMg57GUiciurh7rBXMGGlmo6z13KlcTDisKcd/jycSrXQjBwD5sy4k5Fgt7M/UNkpIZzfRQd5xAPXbuR5kJPItLQ6MkPXEX5OBZhm58bSsi+kOFG41iBkIGzvV9HFyfIO+SBIgLqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQcY6/seaWjT6HlYkJoWw41YS0eAemwiXnaHwLJpnN0=;
 b=b1ACPjOZpg7kVUApwQobnaa2KpRgYosWxqd6NAPC9xtGGlG0JIssyHv1BJESRP1uU29+i1Z7Ciur/eZ3wei0OR0jTM8FHBQSIUK+XDd6p8YzdiyS81w+PQut36AtjO4GaWyQa7Hxy+ZcLTDFupWhK9KM/SYl9l8LlhClAyaAemuCiqfy78/FeBc044XYlvcqhoTJjxGkbnrqqj0vslZv5HRzjXwvCnmH7XDHsLO33EA/+aQgUJoxv0d/fQvnz9oMpLdvZhLImsBVxIf2NH6usTH/3Q9+0ziu3bfUVCn4rzp7wXc4BKC7D4NWGlF9nPMfWo8aKhTSgqsabFOaqLdsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQcY6/seaWjT6HlYkJoWw41YS0eAemwiXnaHwLJpnN0=;
 b=rtsh2s6Eg8aS95WUGvgXISONOeqMoSFnfKtHZwJcmMM9l016tC5yIfFouX/t43Z7LU6DWT8JGdIkWyicTdKnJcvHEtj/upZqJfYjwuIBYCGYhGyDPO1n1e9R67Nio5fpkZbkqYibdI5iO92kQ1yDAyceYgwWH9JnNRnOFeWBVOQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5486.jpnprd01.prod.outlook.com (2603:1096:404:802d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 09:30:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 09:30:19 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Thread-Topic: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Thread-Index: AQHYZIA3TRVrx9T/skGzEuiCwjtE0q0jmkqAgACR+bCAANHPAIAAA1bggAD1JACAAADlIA==
Date:   Thu, 19 May 2022 09:30:19 +0000
Message-ID: <OS0PR01MB5922D0FFFA82AC5428F8C8D886D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
 <20220517210407.GA1635524-robh@kernel.org>
 <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220518181730.GH3302100-robh@kernel.org>
 <OS0PR01MB5922BC7AAC6154DEF7B98F0386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWPy4HmPrfnL8kZmFBBcHY-EoNm7Z6CoJyudhKornTS=g@mail.gmail.com>
In-Reply-To: <CAMuHMdWPy4HmPrfnL8kZmFBBcHY-EoNm7Z6CoJyudhKornTS=g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7419a95e-a6c3-4ccb-3067-08da397a3109
x-ms-traffictypediagnostic: TYBPR01MB5486:EE_
x-microsoft-antispam-prvs: <TYBPR01MB5486FFF95EC63AE1ADF8662986D09@TYBPR01MB5486.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6Uq934uKqLldDIscXoUZXKYji0EyWufMWndjaWtljRwd47eivy7LSPPj+MN3F8tBTleq64mvwImFu2vj4+YAUf1Wz0pl9lTkgr5ygr1Ls3pryYrFMgghZZ6948UdVTozk1BJWVtR6lIc78+yQIiOpEbmhLD8J5wleqgwHwrOAVBGPy6NpsNFtpBvW5WXlkaluf26WFJv8DuGg8PbZZcE8HXlxgPC5FyruCDi9DRb6Z4fMyUyo9+vFaTK6jaukHwfHGmq8fzZQ9wo/BoXC7TFmajf7vLiaNfLlw06FZa1yhGZWhCfI931w6hSNg+y7HSoDJdPLdcsxu8PgQdupmyQVZe2hHmQsc2Rv08F+Jb4exaqD1/x2oJAgNjAtoohesyjROT7NFWy2T87PQng37JHZAmEi1uEDict6dayQDEOBFXga8vyvohGEUvJs6+NQXpdxwt60fp3flpJ3kcIl1VPG9Z96EwuooscgEzMrsGRjfYvjdXzMU7C7gDTdm4xnahLmrCCCWH7e0YN6cO4CJu1/R0urymIW9pfpleDbRNLbt7MDJt8KF68kjo9bnp+mGFFz6onnAKuZJc74Ubpwfhv6eTkkp88Z/CPfInFcyiejGTkaCPUP6if9M9e8NwPEPorh1PGamFT+KP+K2RXtRvRJMzox+WDoSTbmvvdMnR0Hukewl3LmUse4xSju+Ao1uQPE3DXapTSsC+md8OCyEhcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(66946007)(71200400001)(6506007)(7696005)(64756008)(38100700002)(66476007)(508600001)(66446008)(66556008)(26005)(8936002)(4326008)(8676002)(76116006)(186003)(86362001)(6916009)(38070700005)(54906003)(52536014)(316002)(2906002)(7416002)(122000001)(5660300002)(33656002)(55016003)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEdSRmwrM1VZR0g3U1lWZmUxSTFEaGN1ay9EYmlwT1VQcmNEQm9JNTR6dlBL?=
 =?utf-8?B?b3NFQ1VyWEZWdCtkTkQ3Z2hZaGYwbC9tN2pkekc5T2FnRWVQZ2lObEtYYWY1?=
 =?utf-8?B?NUxiTEhPVi9mMzBRRU5xWERQYmRvQ1dRUnhhTFo4U1llU3RXSUM5WWVoTnFz?=
 =?utf-8?B?c1ZuOWtBY0k0ZVdVVmxaMnlzbTduNDY2OTcrWWJmT3lZdEhOOEhkQVdMZ0tR?=
 =?utf-8?B?ZklucUFFb203UGwxK0NseW1OTGIwVkhIUTJkN29vcHR2VVRtOTJRdHdud1F2?=
 =?utf-8?B?QlllOHBDekNvRWxtQ25CQ0FWTjRlYzNETExhc2RBdXhmTVkxV040ellwQmZo?=
 =?utf-8?B?VEJVcW1UNEJUNk1pN2NCaGR1MmE3ZTQ0S3VwdTdhUEhhcWc2OW9xTHdUazY0?=
 =?utf-8?B?SkJ5T1hYa0xMbzcyZkxlWUtUV2IrY3dIL2VxWmJlTFpKTlpWSDZ1RE83RUN6?=
 =?utf-8?B?Sk45UWlZSTR3ZEdvL1lmN1NPZWZrdFd3c3VWQThJUlVHME1QN245dGtvbDEx?=
 =?utf-8?B?RHdOVVIydms5NnpORUN4V0lCWDA5Z3dIMXgvN1VEL3VFaWova1d2dnhvQng1?=
 =?utf-8?B?ZEFwbHlxeUNIOTQ1L2QvWTlObkxES1NBczRyQ2pHVTlSbTdMTFJScGNmZmZK?=
 =?utf-8?B?RmMxSjVqKzBCS1NhLzdRNkM0SlhmYXdveWN0bDIxZmlxb0UxWTQwektOcmk1?=
 =?utf-8?B?V0tiWUlycGxMZVZWYTY4Nmg2NktMUWF1MTVWakpJRmJNS013TzN3aG1kdXN4?=
 =?utf-8?B?bDN4QTZjSzZaVjAyanZEYVZKbzdFT2ZrTmVQNld6WlVZWFNockNERlFSS2xn?=
 =?utf-8?B?RHJlVVB1QXhIMzJKcFhUK1p1V3JZQ2ZFMEhvdE9MTExNamZNOGV3RUhtTy9h?=
 =?utf-8?B?bnVDUXNoMzE5c0t2dmlQUHlRUFFOZG9YdEZpZHJ6YjgrclJaYXUxUVFWN2Js?=
 =?utf-8?B?TnJCbmFHbXVCWlNQWm1LUDd1M2RSemJKbGxVeVhJSnlEU3luZ3IzNHJjbVRm?=
 =?utf-8?B?MmRvRXJCK1BabHVLUHJmNEsrZzYwR3MzYk1qdk9EWGJtemhxUTUvVXNNRGhT?=
 =?utf-8?B?YWU4RDlkQmdYT3pTU1lYc1VneTU0SG80RjJFWTA5TWYrVkNqNGF0RWhDTEYw?=
 =?utf-8?B?MlcvcUsyS1JKalFSSTZhdUVVT0QxcmpoYnBHRjQxR3B1NGZzMW1IZXV6Y1FO?=
 =?utf-8?B?cHQxZ1FOOG5RR3gwUWs0QmtDVS94U1J6cTgyekU2VmNzTHRVZG9rblp3TkVX?=
 =?utf-8?B?THZtd1A0d1oyVS95bURpMTVZWlYzQ3F6N2hBaDV4d0Rlam9odi9TV1B6VXRN?=
 =?utf-8?B?aGlnaW15WXJsaVBEd2J6bFVQM3p5VkpqaHlIblJxRzlrOTFidCtTU3RZWGx5?=
 =?utf-8?B?ZnFyWHFDWHZEczh1STBsRHlWNURaa0JYYVlIczF5RUIxbm4wcFN2NzlwYWhm?=
 =?utf-8?B?UEUvNHU5Ni9nd05reHpUQkxGRlZkZlFqcUgrYnl6Nzc5TUR4VFRaeGk2d2t6?=
 =?utf-8?B?bHV3UUYrOEZIWXVKNWU3eTcvVndSYWoyeERXTDlVVEl6OUQwaXBXN0VOcjR6?=
 =?utf-8?B?OUFZVVdFd1dtMjlZMTVTb1NBRnd1U2pRMnZWUUVtQ01IN0Vpa3BaMGxFRUFN?=
 =?utf-8?B?TmZwV0IzV29nS0JBQTg4WWZFR1hibjVMTVI5L2xvS1hBNGYwbG54a1RVdTlV?=
 =?utf-8?B?d0ZGU2tpR1JKQmQvWVRaQ3prc1RhWUdSbVB1YmdiVHMwYmtRSitYSXVFVHha?=
 =?utf-8?B?aXJ4a2d1ZE8xb3NuWmpXME9CTnI0MkxRRnRpSGlJUEplZWpnNE5CejlJaUQ0?=
 =?utf-8?B?QnRaYkkyUkxTcWx5UVZBZ1Mwc0ZlZHhveUZpbm40akljbG1JVElReHpJbmMz?=
 =?utf-8?B?SEFCTXppaERseFg1Wnpoc0lDUkpJZHdyR3ZLaDhqM1kreEpVdExYVUNoN2dX?=
 =?utf-8?B?RERhZFgvQlQ5V2ttYkpJZTZ4ZXFRbS9JemdUVUgvQzYwSldzenJOdjNkUmV4?=
 =?utf-8?B?L3JoeHZXa2pVTFpNUnZkbFJ2bUk1SDhpeUhseHR1VFA0bW1KR25jTEx0b2xV?=
 =?utf-8?B?bGNzenQ2S08yUEpiOHZYV2prcmhuVDNqd0Y0TDlYUTF5d3ZQQ3BjZUhVaG4r?=
 =?utf-8?B?ZVlOSFdsdWpFQUY5aUxoV2kzRDFGS3BKUUdpMkZiVmt2WDhxczlTRnYwdE92?=
 =?utf-8?B?UlBOclB1QlRWbmp6eGRLdnBEb0ZkeFYxK2trUUZNUExmTDl4QnQwS0JYQU1H?=
 =?utf-8?B?bmdrSi9yaHRpNWhWNnpaSXFJTUFicWU0c2Exd3dUSTcvK2gxblF1d2UzbHhS?=
 =?utf-8?B?RHprajlFejNiY0QreThpcDVqMWZWQTB4dFZBNFFvNzdkNEhHc2lISHRoSk5r?=
 =?utf-8?Q?sJywK18cV3KZW51w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7419a95e-a6c3-4ccb-3067-08da397a3109
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 09:30:19.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89U/sVBUNlBFKSjVh0wdDLXx6jsncIjpcSFPIO8g8ypuFbQZjmzX/7qb6zI3Lj1dP6ouuYPyH0C25C47dYeLKW50C5OAxftqWFNb3/e+fec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5486
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UkZDIDEvOF0gZHQtYmluZGluZ3M6IHNvYzogcmVuZXNhczogQWRkIFJaL0cyTCBQT0VHIGJpbmRp
bmcNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIE1heSAxOCwgMjAyMiBhdCA4OjM0IFBN
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1JGQyAxLzhdIGR0LWJpbmRpbmdzOiBzb2M6IHJlbmVzYXM6IEFkZCBSWi9H
MkwgUE9FRw0KPiA+ID4gYmluZGluZyBPbiBXZWQsIE1heSAxOCwgMjAyMiBhdCAwNTo1ODowMEFN
ICswMDAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1JGQyAxLzhd
IGR0LWJpbmRpbmdzOiBzb2M6IHJlbmVzYXM6IEFkZCBSWi9HMkwNCj4gPiA+ID4gPiBQT0VHIGJp
bmRpbmcNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFR1ZSwgTWF5IDEwLCAyMDIyIGF0IDA0OjEx
OjA1UE0gKzAxMDAsIEJpanUgRGFzIHdyb3RlOg0KPiA+ID4gPiA+ID4gQWRkIGRldmljZSB0cmVl
IGJpbmRpbmdzIGZvciB0aGUgUlovRzJMIFBvcnQgT3V0cHV0IEVuYWJsZSBmb3INCj4gPiA+ID4g
PiA+IEdQVA0KPiA+ID4gPiA+IChQT0VHKS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiA+
ID4gPiA+ID4gK2V4YW1wbGVzOg0KPiA+ID4gPiA+ID4gKyAgLSB8DQo+ID4gPiA+ID4gPiArICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9yOWEwN2cwNDQtY3BnLmg+DQo+ID4gPiA+ID4g
PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2lj
Lmg+DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgIHBvZWdnZDogcG9lZ0AxMDA0OTQw
MCB7DQo+ID4gPiA+ID4gPiArICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMscjlhMDdnMDQ0
LXBvZWciLCAicmVuZXNhcyxyemcybC0NCj4gcG9lZyI7DQo+ID4gPiA+ID4gPiArICAgICAgICBy
ZWcgPSA8MHgxMDA0OTQwMCAweDQ+Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBsb29rcyBs
aWtlIGl0IGlzIHBhcnQgb2Ygc29tZSBsYXJnZXIgYmxvY2s/DQo+ID4gPiA+DQo+ID4gPiA+IFRo
ZXJlIGFyZSAyIElQIGJsb2NrcyBHUFQoUFdNKSBhbmQgUE9FRyB3aXRoIGl0cyBvd24gcmVzb3Vy
Y2VzDQo+ID4gPiA+IGxpa2UgKHJlZ2lzdGVyIG1hcCwgY2xrLCByZXNldCBhbmQgaW50ZXJydXB0
cykNCj4gPiA+ID4NCj4gPiA+ID4gTGFyZ2VyIGJsb2NrIGlzIEdQVCwgd2hpY2ggaGFzIGxvdCBv
ZiBmdW5jdGlvbmFsaXRpZXMuIFRoZSBvdXRwdXQNCj4gPiA+ID4gZnJvbSBHUFQgYmxvY2sgY2Fu
IGJlIGRpc2FibGVkIGJ5IHRoaXMgSVAgZWl0aGVyIGJ5IGV4dGVybmFsDQo+ID4gPiA+IHRyaWdn
ZXIsIHJlcXVlc3QgZnJvbSBHUFQoRGVhZHRpbWUgZXJyb3IsIGJvdGggb3V0cHV0IGxvdy9oaWdo
KSBvcg0KPiA+ID4gPiBleHBsaWNpdCBzb2Z0d2FyZSBjb250cm9sKS4gVGhpcyBJUCBoYXMgb25s
eSBhIHNpbmdsZSByZWdpc3Rlci4NCj4gPiA+ID4gQ3VycmVudGx5IEkgYW0gbm90DQo+ID4gPiBz
dXJlIHdoaWNoIGZyYW1ld29yayB0byBiZSB1c2VkIGZvciB0aGlzIElQPz8gT3Igc2hvdWxkIGl0
IGJlIG1lcmdlZA0KPiA+ID4gd2l0aA0KPiANCj4gWWVhaCwgUE9FRyBpcyBhIHdlaXJkIGJlYXN0
Lg0KPiBTb21lIG9mIGl0IGZpdHMgdW5kZXIgcGluIGNvbnRyb2wsIGJ1dCBub3QgYWxsIG9mIGl0
Lg0KPiBGcm9tIGEgcXVpY2sgZ2xhbmNlLCBtb3N0IG9mIGl0cyBjb25maWd1cmF0aW9uIGlzIGlu
dGVuZGVkIHRvIGJlIHN0YXRpYywNCj4gaS5lLiBjb3VsZCBiZSBkb25lIGZyb20gRFQsIGxpa2Ug
cGluIGNvbnRyb2w/DQo+IEkgaGF2ZSBubyBpZGVhIGhvdyB0byB1c2UgdGhlIFBPRUcgaW50ZXJy
dXB0cywgdGhvdWdoLg0KDQpJZiB0aGVyZSBpcyBhIEdQVCByZXF1ZXN0KERlYWQgdGltZSBlcnJv
ciBvciBCb3RoIG91dHB1dCBsb3cvaGlnaCBjb25kaXRpb24pIG91dHB1dCBpcyBkaXNhYmxlZCBh
dXRvbWF0aWNhbGx5IGFuZCB3ZSBnZXQgYW4gDQpJbnRlcnJ1cHQuIE1heSBiZSB0byBjbGVhciBp
dCAsIHdlIG5lZWQgdG8gaW1wbGVtZW50IGludGVycnVwdC4gT3RoZXJ3aXNlIG91dHB1dCB3aWxs
IGJlIGFsd2F5cyBkaXNhYmxlZCwNCmV2ZW4gaWYgdGhlIG91dHB1dHMgYXJlIG91dCBvZiBwaGFz
ZSBhZnRlciB0aGUgZmF1bHQgY29uZGl0aW9uLg0KDQpJIGhhdmUgZG9uZSBhIHF1aWNrIHRlc3Qg
d2l0aCBpbnRlcnJ1cHRzIHByZXZpb3VzbHkgZm9yIG91dHB1dCBkaXNhYmxlIHVzaW5nIEdQVCBy
ZXF1ZXN0Oi0gDQoJVXNlIGJvdGggQSBhbmQgQiBpbiBwaGFzZSwgb3V0cHV0IGlzIGRpc2FibGVk
IGF1dG9tYXRpY2FsbHkgYW5kIHlvdSBnZXQgYW4gaW50ZXJydXB0IGluIFBPRUcgYmxvY2suDQog
ICAgICBJZiB5b3UgaW52ZXJzZSBCLCBpdCBpcyBvdXQgb2YgcGhhc2UgYW5kIGZhdWx0IGNvbmRp
dGlvbiBpcyBubyBtb3JlLCBidXQgc3RpbGwgb3V0cHV0IGlzIGRpc2FibGVkLg0KICAgICAgSW4g
dGhpcyBjb25kaXRpb24sIElmIHdlIHdhbnQgdG8gZW5hYmxlIG91dHB1dHMsIHdlIG5lZWQgdG8g
Y2xlYXIgaW50ZXJydXB0IHN0YXR1cyBiaXRzLg0KICAgICAgICAgICAgDQo+IA0KPiA+ID4gbGFy
Z2VyIGJsb2NrIEdQVCBieSBjb21iaW5pbmcgdGhlIHJlc291cmNlcz8NCj4gPiA+DQo+ID4gPiBV
c3VhbGx5LCBJUCBibG9ja3Mgd291bGQgaGF2ZSBzb21lIG1pbmltdW0gYWRkcmVzcyBhbGlnbm1l
bnQgKHR5cCA0Sw0KPiA+ID4gb3IgNjRLIHRvIGJlIHBhZ2UgYWxpZ25lZCksIGJ1dCBpZiB0aGVy
ZSdzIG5vIG90aGVyIElQIGluIHRoaXMNCj4gPiA+IGFkZHJlc3MgcmFuZ2UgYXMtaXMgaXMgZmlu
ZS4gVGhlIHF1ZXN0aW9uIGlzIHdoYXQncyBiZWZvcmUgb3IgYWZ0ZXINCj4gdGhlIGFib3ZlIGFk
ZHJlc3M/DQo+ID4NCj4gPiBBcyBwZXIgdGhlIEhXIG1hbnVhbCwgYmVmb3JlIEdQVCBJUCBibG9j
ayBhbmQgYWZ0ZXIgUE9FMyBibG9jayhQb3J0DQo+IE91dHB1dCBFbmFibGUgMyAoUE9FMykgZm9y
IE1UVSkuDQo+ID4NCj4gPiBCZWZvcmUNCj4gPiBIJzBfMTAwNF84MDAwIEgnMF8xMDA0Xzg3RkYg
MiBLYnl0ZXMgR1BUDQo+ID4NCj4gPiBBZnRlcg0KPiA+IEgnMF8xMDA0Xzk4MDAgSCcwXzEwMDRf
OUJGRiAxIEtieXRlIFBPRTMNCj4gPg0KPiA+IFBsZWFzZSBmaW5kIHRoZSBhZGRyZXNzIG1hcCBm
b3IgdGhlIElQIGJsb2NrcyBuZWFyIHRvIGl0Lg0KPiA+DQo+ID4gSCcwXzEwMDRfQTAwMCBIJzBf
MTAwNF9BM0ZGIDEgS2J5dGUgU1NJRiBjaDENCj4gPiBIJzBfMTAwNF85QzAwIEgnMF8xMDA0XzlG
RkYgMSBLYnl0ZSBTU0lGIGNoMA0KPiA+IEgnMF8xMDA0Xzk4MDAgSCcwXzEwMDRfOUJGRiAxIEti
eXRlIFBPRTMNCj4gPiBIJzBfMTAwNF85NDAwIEgnMF8xMDA0Xzk3RkYgMSBLYnl0ZSBQT0VHRA0K
PiA+IEgnMF8xMDA0XzkwMDAgSCcwXzEwMDRfOTNGRiAxIEtieXRlIFBPRUdDDQo+ID4gSCcwXzEw
MDRfOEMwMCBIJzBfMTAwNF84RkZGIDEgS2J5dGUgUE9FR0INCj4gPiBIJzBfMTAwNF84ODAwIEgn
MF8xMDA0XzhCRkYgMSBLYnl0ZSBQT0VHQQ0KPiA+IEgnMF8xMDA0XzgwMDAgSCcwXzEwMDRfODdG
RiAyIEtieXRlcyBHUFQNCj4gDQo+IFRoaXMgaXMgYWN0dWFsbHkgOCB4IDI1NiBieXRlcywgZm9y
IDggR1BUIGluc3RhbmNlcy4NCg0KWWVzIGNvcnJlY3QuDQoNCj4gDQo+ID4gSCcwXzEwMDRfNzAw
MCBIJzBfMTAwNF83RkZGIDQgS2J5dGVzIFNSQyAoUmVnKQ0KPiA+IEgnMF8xMDA0XzAwMDAgSCcw
XzEwMDRfNkZGRiAyOCBLYnl0ZXMgU1JDIChNZW1vcnkpDQo+IA0KPiBTbyB5b3UgY2FuIGNvbWJp
bmUgR1BUIGFuZCBQT0VHW0EtRF0gaW50byBhIHNpbmdsZSBibG9jay4NCj4gSG93ZXZlciwgZG9p
bmcgc28gd2lsbCBtYWtlIGxpZmUgaGFyZGVyIHdoZW4gcmV1c2luZyB0aGUgZHJpdmVyIG9uIGFu
IFNvQw0KPiB3aXRoIGEgZGlmZmVyZW50IGxheW91dCwgb3IgYSBkaWZmZXJlbnQgbnVtYmVyIG9m
IFBPRUcgYmxvY2tzIGFuZCBHUFQNCj4gY2hhbm5lbHMuDQoNCkkgYWdyZWUuIE1vZGVsbGluZyBh
cyBhIGRpZmZlcmVudCBkcml2ZXIgZ2l2ZXMgbG90cyBvZiBmbGV4aWJpbGl0eS4NCg0KQ2hlZXJz
LA0KQmlqdQ0KDQo+IA0KPiBCVFcsIFBPRTMgaXMgYSBzaW1pbGFyIChpbiBzcGlyaXQpIGJsb2Nr
IG9uIHRvcCBvZiB0aGUgTVRVIChNdWx0aS1GdW5jdGlvbg0KPiBUaW1lciBQdWxzZSBVbml0IDMs
IHdoaWNoIHNlZW1zIHRvIGJlIGFuICBlbmhhbmNlZCB2ZXJzaW9uIG9mIHRoZSBhbHJlYWR5LQ0K
PiBzdXBwb3J0ZWQgTVRVMiBvbiBSWi9BMT8pLg0KPiBCdXQgdGhlIFBPRTMgYmxvY2sgaXMgbm90
IGxvY2F0ZWQgbmV4dCB0byB0aGUgTVRVIGJsb2NrLCBzbyB5b3UgY2Fubm90DQo+IGNvbWJpbmUg
dGhlbSB3aXRob3V0IG92ZXJsYXAuDQo+IA0KPiBOb3RlIHRoYXQgdGhlIG1pbmltdW0gcGFnZSBz
aXplIG9uIENvcnRleC1BIHNlZW1zIHRvIGJlIDQga2lCLCBhbmQgc2V2ZXJhbA0KPiBibG9ja3Mg
YXJlIHNwYWNlZCBhcGFydCBsZXNzLCBzbyBldmVuIHdpdGggYSBkaWZmZXJlbnQgT1MgdGhhbiBM
aW51eCB5b3UNCj4gY2Fubm90IGltcGxlbWVudCBwYWdlLWJhc2VkIGFjY2VzcyBjb250cm9sLg0K
PiANCg==
