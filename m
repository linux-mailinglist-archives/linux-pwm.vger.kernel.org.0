Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A125FBC10
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJKUbz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJKUby (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:31:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151774E20;
        Tue, 11 Oct 2022 13:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3nCGtB2z54AS9/KzorBHAiBKBN0q4qKdODrngLTIOvHqRCZYzNlmf1zGjWHQvL9w1IqacQNNUuOHWQJATeBH+qvnbc35yoTmORpg82hOR6yeGDJECoDxBAbzBK0SeKZ999SM/EsUyhej41krnw+v/mTr2FoAHxSfT4pLdOOXy5ExlbESHl/ja1nsOAEiKTml0zPdN5h6LX+2FLBX36FbSk771mKjDoBPeku6jGQJC5xtLT/zKvqxwg6PeNnj6ucI/354dMlYj8qO51CxxBCtXrXblM3mWpTEJGx73y7oCBj7wGIVFNLH+qpwha+dkZyfCOk0mhfo6rAo83yXuOcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBLhHyqds04J050jzF/1adTdONqKOo3aazKELu5h5PY=;
 b=bFuFr42KBlrMKX0EfvJdEgaV08wk2nPN5ZG0iga7VyI1h40ZrG3kQsiQzEj4Xy2x4Rhgi/1Z5I5aHqE2QkwhVIwkSizsB7oN0M46KcOPoxoSJn/ZrInbHZvm4guKM2WXTMWFRn51ZeAvk6pfJiqtCifRE6927EOFGNYLE18IcQxVJxEBHI45MVlP7Mf39YYOLgfmnzuxXdEkN85+4tiymw/q6PQKudvJIpw3bXQdANE0Ok4qfniogvUX6+csBoXBGYUed+zgO243nKTo0kSKUS1NokSon0qKfDxakTEPGuUnVrgI9nsMTxb5YAZvJUJ0dt37Q6IBG2N4xT3/eZWXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBLhHyqds04J050jzF/1adTdONqKOo3aazKELu5h5PY=;
 b=G1nFDC6vu68JYHScNcNjUFKaZB3uqEwPDnDbMNRCxV7q9uutqPmLXvaXB3yae1hZJfUa0CcrppUTAFbICAtfNEANthREJNHTVUktbFAYgI1XDxcRbRW977lma5/hXGdYgz1dQgK07Kklvld4uSkDQBkvzFsM2zhdZ15ZTihXnKs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8112.jpnprd01.prod.outlook.com (2603:1096:400:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 20:31:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 20:31:48 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY3LfvgCpXQRSGOUCqUs4Dd5zxEq4JRt6AgAAA/2CAAESYgIAABVgggAARxgCAAAEEsA==
Date:   Tue, 11 Oct 2022 20:31:48 +0000
Message-ID: <OS0PR01MB5922152268684B5564AA170D86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
 <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <17fc9f27-03ad-7663-db21-2f14c7ff4312@linaro.org>
In-Reply-To: <17fc9f27-03ad-7663-db21-2f14c7ff4312@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8112:EE_
x-ms-office365-filtering-correlation-id: f1913f2c-f4b0-4fe2-71bb-08daabc79f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +XMmoftIXgnipnTNVvl2OWhvgu9JuN3WH2NsPbyo+mRc9jWv5yeKz5VlQ/eArMk4N6E2ikZJnLvLrqc14k1KZ8JMdzOerVRuIx9HhPTJctj0M5+x01NAqiEzRBfBrfWqazWYMoSSm6IYLTtmGYLH8UCp1tACzpUdeffSGO/8wdMGY3VDxbyt3Guu6boItmSHogi+n1E4wnLl2qnI5jfbyHVvcjqLGCiRV6b6Ler1aJoXBN4n3cP5eD4Z7HRkw1vFoUkluOuzi65Z8H/PpBRg81BTE8pTuSyxU3jAqh23CKVnlPJgYmbT6tNa0RC3WJ9N3xQl1R6fOfezQj/Wbe7vSTxqB8jTO0bDz/Ix2B7FtDdjqo8vke4ikSS7QN1oxipj/az0kj2kjBqPY4LGzk/iHGotKhY8rOfvWbC97JEODrtXFdJrYzMaAMAYdwCFhKYcPo5bpm8gTJj7reXkK+ANbR4ecO/UZHOPi45XzffF2MXA7OLf3lXKOjvfWjL8qOQDwstEf35dlDJzLJ9hJyd/AZCTQUDVMp9QhaFSi53uBjnK6bg+KBQaJpLYWnMOcZK+hJ/yivGv0NDDy54Mwmb8gBLYwAUXma97W5PlbVpRJFX9cDiV/nKVC8/VfojzEClzqLVKkVDDwi/PpnPsv1PMf4B4VVNKtcBsGh6RKCG2WgXUMFMqLVmQbbEu6XxOEzZYeos02cJKjGqHotSe5zAdWkh3fzxtYGHR73MCxhejijRFlUfkZSqDePx9Xcsqa2AOGaH68jh6QPVKWy7hwf+e5KVkAkmeU6mmPFbMawvsfx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(66556008)(66946007)(41300700001)(66476007)(66446008)(64756008)(86362001)(186003)(8936002)(2906002)(55016003)(38070700005)(54906003)(71200400001)(7416002)(5660300002)(110136005)(33656002)(83380400001)(8676002)(4326008)(76116006)(316002)(52536014)(478600001)(26005)(9686003)(7696005)(38100700002)(122000001)(53546011)(6506007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHNWMzZWVWtSREhBSE43UUl6MWE4UWJMN1pjSU51clNrMkI0WFZKbU5FODZD?=
 =?utf-8?B?TTNPNkp1RXJ6bWJycWUrYTRuWnp2VWpTSWEyNHFkbFRJSEVNQjBOK0dTbVVZ?=
 =?utf-8?B?d21XMGU1Rnh2QnpyaFcxVVhvOHBWeXltWnBybDV5Y2JSMEU3TjI3YU9rZzRy?=
 =?utf-8?B?WlBBbFdLNGVvVFVOeVptdUYyZ0xtOXNJVXNPR3p6c3E1MnNIZXoxcGhqQjg1?=
 =?utf-8?B?R3RXOCttUURvZ3JvSU5tdDVQOXU2VFhBdzd5ZDBCWU1GWjkyWllxdE0xejFt?=
 =?utf-8?B?V29rVll3QzU5LzBZeU5EUjVJNkowdWtjTmpyeFhlY0FXbGltd3crYmwzeER5?=
 =?utf-8?B?S2FXSGg0YjJNaHRTZ3ljTG8zZEFLSFhRR0RJOUJIRDIvYjFSa3pSeVp5akdX?=
 =?utf-8?B?bFJ2ZGVudEEvZUZ2WUVKbGhpQlhlRWJ3eitKOG1iSHBBdlRGL055TldBR2F5?=
 =?utf-8?B?aGtpSmt4aW91czZFeTFFR2lXaHp6T09kMU84SGRocUhKeFR2ZG9leUoxNTd0?=
 =?utf-8?B?SStaaU80UHJOYjEvSWlVUFdqU2E3Y0xad1d6c3g5cUxTUGpzOXZ6TWI5SldT?=
 =?utf-8?B?VVBFaGVubGdLRnlJTXNhcXRxRnUxWGw4RG85cUtHenFTWU9ONHgyb2ZVbWtt?=
 =?utf-8?B?N3Z3UzZjVWdLVGN0TTlmRnVMTm14eW42UEVWbWZHTmNIcWJORnFpU3VKTTVU?=
 =?utf-8?B?b014WWtaK1hMbE5RaUhtNWtEeGh2RWlMS3JhYXI1bkczQkhUa1FzQ2tJNWdi?=
 =?utf-8?B?djRXYk8vNG5WYlFYN2Jzdk1IQ1hHRHlCb1JRanE1MlJGdkcvdzNMYnZ2b0dS?=
 =?utf-8?B?c0t6Vm1oV3RJcW5KelJ5SG05ZHBERU1Eb3MwSGhmb21VZlkvMUJxM2lNMHRH?=
 =?utf-8?B?RlE4RmpHQjVrSnpYWHFPeTNUU1pJK2FsVVRySmptaGJ0Yk9Za2JYVEJtU2JW?=
 =?utf-8?B?R05BbXNmcUI1YWF0bitxcDc4Nkk4YzYreWVVakUwOEFQVG1LZFdKODNQQjI4?=
 =?utf-8?B?Q2RRaHlUZmxJWi9sYUdycEtGUlM2OEErRUc3bmNYUnN2Yk95YTJVWkN2Ulpk?=
 =?utf-8?B?eEJybmJqUTNFbG1NOHl3WFlRZFhuOENaNVRXS2pRejBDQWJoMVR2YlRweUl2?=
 =?utf-8?B?Wk9XZUVNVnpmdkwxQUhkUmdVUFA0SDdYY0REbXlwZ05uUVNZdkRKSXBvN09p?=
 =?utf-8?B?TUZJTmwwQWJBclhLNXY2ZVZ1NHhNNVZGVmZaT1oyZHQ2WkJGQ0pSbmgzZTNL?=
 =?utf-8?B?STZBTExGRThpZ3RyTmU3LzdqZ1orc3RyWkoyQXp5aEdPS1dxU3BrWGhkcnor?=
 =?utf-8?B?QXN4QVRjQWVWRnVvYWRsNTFNcitZVmhzZ0tqSlhQYklZam1NMVl3aEZtc1p4?=
 =?utf-8?B?aDFKMFBBVjNEUS9RL2lnNTRwc05tZkhEcGFtbEpNdk1ESi9Bb0E2V1h5Y3FB?=
 =?utf-8?B?dUFHSFNnL09raWJ1ZmhhS0RoNkNNcGkydG12Z2hyN1dKa2ZlbmRiZEZIL1B0?=
 =?utf-8?B?SHdwbTNkTXBuajBldFpic3g0V0RndXVSeVhoK3VCTllxQzFKeFFjZko1WHNh?=
 =?utf-8?B?VWprMUJzTitFNGQ0Y0ZuTFc1TjNGNXljaWtBWXE1amFINXRONVIwZ2cvaUNw?=
 =?utf-8?B?emVyZ0RodDdDTklJampUc2lvdEw2SDRiK0VhZWhqNXpMZlBpRVRqc0Fydlp4?=
 =?utf-8?B?K3IyWWRCdFNwY2xrUFZxOWRwVW5taWR3ZlJ2R2kxWW5Wc0ViU2UvZlozRzBX?=
 =?utf-8?B?blhGV3ZpSGtrL0liZngxbWQycWgwRzNxMm9mU1IrUXdhOHpNbWFSSWtaTHRK?=
 =?utf-8?B?WTlmd1A1aTcrWDhSTGUyeEZNcGRjM3JaemZKdlNrUnlZYUNBQWFyRkRxWG53?=
 =?utf-8?B?K3QyMmNtditqY1hGdVR3QUdheUZjaGJvQktuRTRnc2tWa0VPQTkyaEREVVdH?=
 =?utf-8?B?WHI2UlE2N2hRZm1ROHUvYXBLSE9jQmJaL2QyTGdPWnVIRFFwQ1JSemM4YTdG?=
 =?utf-8?B?a3FiZ0JzWk1qV01wRzFqYmd0R1JCLy9Leks0VHpmc08xMW9Xd3dlQUhZNDkx?=
 =?utf-8?B?Q2tCZkh3TWNXczRJOURzN0xnL2VCTUdzREpncmdxQkxYQ2pHL2ZCQXc0V29H?=
 =?utf-8?B?aTlKUThCem9MdjZPWFAzMkNzQkQ4WWlYM0VZbk5PazBRazZTQ213anErTnM4?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1913f2c-f4b0-4fe2-71bb-08daabc79f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:31:48.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlEJA1OArSCR5vgGJMqccZVEwMNDP7EWXO7GA+Zba0xJMPrDDv4TVjerP6Ot/GMisOyxMz0AFEiHWV2f2CDwhE4S7xJyp7w5SZf2YVtd0sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvNF0gZHQtYmluZGluZ3M6IG1mZDogRG9jdW1lbnQg
UlovRzJMIE1UVTNhDQo+IGJpbmRpbmdzDQo+IA0KPiBPbiAxMS8xMC8yMDIyIDE1OjIzLCBCaWp1
IERhcyB3cm90ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzRdIGR0LWJpbmRpbmdz
OiBtZmQ6IERvY3VtZW50IFJaL0cyTCBNVFUzYQ0KPiA+PiBiaW5kaW5ncw0KPiA+Pg0KPiA+PiBP
biAxMS8xMC8yMDIyIDEwOjU1LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+DQo+ID4+Pj4+ICAuLi4v
YmluZGluZ3MvbWZkL3JlbmVzYXMscnotbXR1My55YW1sICAgICAgICAgfCAzMDUNCj4gPj4+PiAr
KysrKysrKysrKysrKysrKysNCj4gPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzMDUgaW5zZXJ0aW9u
cygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvcmVuZXNhcyxyei1tdHUzLnlhbWwNCj4gPj4+Pg0KPiA+Pj4+IFRoaXMg
c2hvdWxkIG5vdCBiZSBpbiBNRkQuIEp1c3QgYmVjYXVzZSBzb21lIGRldmljZSBoYXMgZmV3DQo+
ID4+IGZlYXR1cmVzLA0KPiA+Pj4+IGRvZXMgbm90IG1lYW4gaXQgc2hvdWxkIGdvIHRvIE1GRC4u
LiBDaG9vc2UgZWl0aGVyIHRpbWVyIG9yIHB3bS4NCj4gPj4+DQo+ID4+PiBNRkQgaXMgZm9yIG11
bHRpZnVuY3Rpb24gZGV2aWNlLiBUaGlzIElQIHN1cHBvcnRzIG11bHRpcGxlDQo+IGZ1bmN0aW9u
cw0KPiA+Pj4gbGlrZSB0aW1lciwgcHdtLCBjbG9jayBzb3VyY2UvZXZlbnRzLiBUaGF0IGlzIHRo
ZSByZWFzb24gSSBoYXZlDQo+ID4+IGFkZGVkDQo+ID4+PiBoZXJlLiBNRkQgaXMgY29yZSB3aGlj
aCBwcm92aWRlcyByZWdpc3RlciBhY2Nlc3MgZm9yIGNsaWVudA0KPiBkZXZpY2VzLg0KPiA+Pj4N
Cj4gPj4+IEZvciBtZSBtb3ZpbmcgaXQgdG8gcHdtIG9yIGNvdW50ZXIgaXMgbm90IGEgYmlnIHBy
b2JsZW0uDQo+ID4+PiBXaHkgZG8geW91IHRoaW5rIGl0IGNhbm5vdCBiZSBNRkQ/DQo+ID4+DQo+
ID4+DQo+ID4+IEJlY2F1c2UgaXQgbWFrZXMgTUZEIGEgZHVtcCBmb3IgZXZlcnl0aGluZyB3aGVy
ZSBhdXRob3IgZGlkIG5vdA0KPiB3YW50DQo+ID4+IHRvIHRoaW5rIGFib3V0IHJlYWwgZGV2aWNl
IGFzcGVjdHMsIGJ1dCBpbnN0ZWFkIHJlcHJlc2VudGVkIGRyaXZlcg0KPiA+PiBkZXNpZ24gKE1G
RCBkcml2ZXIpLg0KPiA+DQo+ID4gQ29yZSBkcml2ZXIgaXMgTUZELCBqdXN0IHByb3ZpZGVzIHJl
c291cmNlcyB0byBjaGlsZCBkZXZpY2VzIGFuZCBpcw0KPiA+IG5vdCBhd2FyZSBvZiBhbnkgcmVh
bCBkZXZpY2UgYXNwZWN0cy4NCj4gPg0KPiA+Pg0KPiA+PiBNRkRzIGFyZSBwcmV0dHkgb2Z0ZW4g
Y29tYmluaW5nIHVucmVsYXRlZCBmZWF0dXJlcywgZS5nLiBQTUlDcw0KPiB3aGljaA0KPiA+PiBo
YXZlIHdha2V1cCBhbmQgc3lzdGVtIHBvd2VyIGNvbnRyb2wsIHJlZ3VsYXRvciwgMzIga0h6IGNs
b2NrcywgUlRDDQo+ID4+IGFuZCBzb21lIFVTQiBjb25uZWN0b3IuDQo+ID4NCj4gPiBIZXJlIGFs
c28gc2FtZSByaWdodD8gcHdtLCBjb3VudGVyIGFuZCBjbG9jayBhcmUgMyB1bnJlbGF0ZWQNCj4g
ZmVhdHVyZXMuDQo+ID4gVGhhdCBpcyB0aGUgcmVhc29uIHdlIGhhdmUgc2VwYXJhdGUgc3Vic3lz
dGVtcyBmb3IgdGhlc2UgZmVhdHVyZXMuDQo+IA0KPiBUaGVzZSBhcmUgcXVpdGUgc2ltaWxhciBm
ZWF0dXJlcyBvZiBhIHNpbWlsYXIgcGllY2Ugb2YgaGFyZHdhcmUuDQo+IFNvbWV0aW1lcyBjYWxs
ZWQgdGltZXIuDQo+IA0KPiA+DQo+ID4+DQo+ID4+IEp1c3QgYmVjYXVzZSB5b3Ugd2lsbCBoYXZl
IGNsb2Nrc291cmNlIGRyaXZlciwgUFdNIGRyaXZlciBhbmQgdGltZXINCj4gPj4gZHJpdmVyIGRv
ZXMgbm90IG1ha2UgaXQgYSBNRkQuDQo+ID4NCj4gPiBNRkQgaXMgbXVsdGkgZnVuY3Rpb24gZGV2
aWNlLg0KPiANCj4gTm8uIE1GRCBpcyBhIExpbnV4IHN1YnN5c3RlbSBuYW1lLiBOb3QgYSBkZXZp
Y2UgdHlwZS4gVGhlIGJpbmRpbmdzIGFyZQ0KPiBsb2NhdGVkIGluIHJlc3BlY3RpdmUgdHlwZS4N
Cj4gDQo+ID4gU28gYXJlIGFyZSB5b3UgYWdyZWVpbmcgQ2xvY2sgc291cmNlLCBQV00gYW5kIHRp
bWVyIGFyZSBkaWZmZXJlbnQNCj4gPiBmdW5jdGlvbmFsaXRpZXMgb3Igbm90PyBJZiBub3QsIHdo
eSBkbyB3ZSBoYXZlIDMgc3Vic3lzdGVtcywgaWYgaXQNCj4gaXMNCj4gPiBzYW1lPw0KPiANCj4g
TGludXggc3Vic3lzdGVtcz8gV2UgY2FuIGhhdmUgbWlsbGlvbnMgb2YgdGhlbSBhbmQgaXQgaXMg
bm90IHJlbGF0ZWQNCj4gdG8gYmluZGluZ3MuDQoNCk9LLg0KDQo+IA0KPiANCj4gPiBXaGVyZSBk
byBrZWVwIHRoZXNlIGJpbmRpbmdzIGFzIHRoZXJlIGlzIG9ubHkgc2luZ2xlICJyel9tdHUiDQo+
IGJpbmRpbmdzIGZvciB0aGVzZSAzIGRpZmZlcmVudCBmdW5jdGlvbmFsaXRpZXM/DQo+IA0KPiBB
Z2FpbiwgZm9jdXMgb24gaGFyZHdhcmUgbm90IG9uIExpbnV4IGRyaXZlcnMuIEhhcmR3YXJlIGlz
IGNhbGxlZCBNVFUNCj4gLSBNdWx0aS1GdW5jdGlvbiBUSU1FUiBVbml0LiBUaW1lci4NCg0KT0sN
Cj4gDQo+ID4gcHdtIG9yIGNvdW50ZXIgb3IgbWZkPw0KPiANCj4gTm90IE1GRC4gSSBhbHJlYWR5
IHByb3Bvc2VkIHdoZXJlIHRvIHB1dCBpdC4gT3RoZXIgVGltZXIvUFdNL0NvdW50ZXINCj4gdW5p
dHMgYXJlIGFsc28gaW4gdGltZXIuDQo+IA0KDQpJIGd1ZXNzIGZvciBjb3VudGVyL3B3bSBtYWlu
dGFpbmVycywgaXQgaXMgb2sgdG8gbW9kZWwgTVRVMyBhcyBhIHNpbmdsZSANCmJpbmRpbmcgInJ6
LW10dTMiIGluIHRpbWVyIHRoYXQgYmluZHMgYWdhaW5zdCBjb3VudGVyIGFuZCBwd20gDQpmdW5j
dGlvbmFsaXRpZXMgYXMgd2VsbD8/DQoNCkNoZWVycywNCkJpanUNCg==
