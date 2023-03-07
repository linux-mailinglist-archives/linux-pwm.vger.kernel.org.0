Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB06ADEEA
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 13:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCGMjm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Mar 2023 07:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCGMjl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Mar 2023 07:39:41 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B95DED5;
        Tue,  7 Mar 2023 04:39:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d40qtWqzf9QuACTMZOcP6TVDHkVrxFN65cOQgW2drdaMjj2gCSWnpy/gscIxJttOSE6Pql/7jcNBHFqL1v0nHhEmRfUO0eTc2pTs/LiMe5i34QsDdLO9HOkiv5Ahxmm6q4iNXRnIArMM7fT5HLQ7LUZpBrptQTwsvHWLyYR+SUTuA7kWBG9F9KbIqLfMs2xuLsi3NjLG5ROscejOMBFq0S2rM79gmCWMwXPII9v2cMqBr6wDiwwyV5tMrMXfYRadl9eiaaWxCCPEK56BEUcQar44/NmkxTipvCaR6s3uobODv27YlEBUAqIewnAl790hysrq1R0kKS9qxZwaE3RApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z2E50xL0riYTQd2comtYuFsCnW5ZewFEgVh0eXv4Tg=;
 b=EfS4GuliP+zUlxOS9D8ImR8MI5kMubsqxW1Gei654cbI2g7qihYpYXn8Lju9bTq/nUnRnYeLCC6KKLwjPa5sIJbZQP/Ifghlfv1O+Blq6NM/u1SozXd26maxw94rxNoxe/b/tLZACHkfl4Azg3H/SRG6+vSZLwMyc+MXXGK1mDRELWIvqOYF5WyAgMcRPgkHA6Yl5F9A7XKBniaFmGA2ry0pMHtbkL+FaVfFf0fUehF5kKqosFdLOsHzw6fBDkIlbFPhzmbkpvaEdqj+oIBi24RW9ocuDmFHNAZbr7R8Wcd4yYprBYHyMBC01p1F/8lSOu1zPyq246CAnpczDg0wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z2E50xL0riYTQd2comtYuFsCnW5ZewFEgVh0eXv4Tg=;
 b=dIpSVkNrLYCVtoErn0+CkmEWAlbTnxJe4fMvVGWC3Jg8lKPN04DslrDCEHtGQrFT/eLnx0OpiOdPd7+iOhFhhVeyr5W+5dP/kDa7FNPVGgSkFMKugbXcxOpMxNHXlsdoN90CVwrGkqGl4a3ETmj1zeznfP1ERjpjSMKPYRWJo7g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8885.jpnprd01.prod.outlook.com (2603:1096:400:16e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 12:39:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 12:39:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Thread-Topic: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Thread-Index: AQHZUAojNP3mD44BfE2nuzra+Sv8J67uaLkAgACVQcCAABiwgIAAAqWggAAnu4CAAACIgA==
Date:   Tue, 7 Mar 2023 12:39:36 +0000
Message-ID: <OS0PR01MB592231D90E0E4F7FB070AE7586B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-7-biju.das.jz@bp.renesas.com>
 <ZAZ43tylTNxPIun8@surfacebook>
 <OS0PR01MB59223AF6B7850592F34CABF086B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAHp75Vcdyq-XKRFKzEjHFQ_0Qv61HkMEVu0Dg-ffsnVc9R3-ww@mail.gmail.com>
 <OS0PR01MB59229CD801939459BB2F8E8686B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAHp75VdJQ0OpVdhJ=9F1tJNXuuYmN2H51tSub+zDkzS3HLUXAg@mail.gmail.com>
In-Reply-To: <CAHp75VdJQ0OpVdhJ=9F1tJNXuuYmN2H51tSub+zDkzS3HLUXAg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8885:EE_
x-ms-office365-filtering-correlation-id: 9f237b35-b177-4f44-a0dc-08db1f0902de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYQUZz9H9DrqCuFRYddXueDWv1wI+PAAzPnLttznJZS9yhccsmf2uwMZ+LTOBGwUozE8iZ0uxL42/IRnXuA1+MDEWcIMaeWgM6YdOCwAl+aOMeKUoSlmOgKKePA0j54qLEwgEKLg6GDL4pvp85jHdTb9NCbFpFinHIFhM+VwbrIwrmbzLK6jcstSRwtqzGe9UooRn8PvlEPCcTyss/LK1/iO3cghDFaDJg9N7/adjMGqTJ+5AESG3gYBmMhozH95Tq0DWEUEziq0O3kOOvq+nq/94qhAADmSt8WHmtjWYB1Vix18pYhEhxzKak/FJJqFyDmpHzHmB6Ice2QOpl1Nwm8TCKgmX13nN9lCq+6579BPmiysaGf+E+UozZ7tptAx+vx2HHjea/NyjB/3O4sjFvCm0SJdoHYC9FEdRE0w3HpZwYhGtHRxk3kDKPaB/yxxGnTpxN5jSzjtEYnkEAkrWgb03zA6kTy9LvJwtsCy8D+jtMMZsELX8tNoEVWp9E+KIpetR5MnlhQuX3N+JUNWCqBuGvHa9gJcKxYPDREO3eCkRATOGGMRb1yt+HBmKiP36OmaPjXRLEWXEK11lghRdBy5tXfhIs2+JywShj5WXS9pYzzn8AgY/6JBidO9gLMshR7X4RliwFqxjn1+/nfsERz50s512EGnYDv1We+7PyjTmL6DmOd70XdpfFEUilbd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199018)(66476007)(66446008)(66946007)(66556008)(8676002)(6916009)(64756008)(76116006)(41300700001)(122000001)(4326008)(38100700002)(316002)(8936002)(54906003)(52536014)(5660300002)(478600001)(186003)(2906002)(7696005)(966005)(71200400001)(55016003)(33656002)(107886003)(38070700005)(6506007)(53546011)(83380400001)(9686003)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNxd1FMMHBuOE9iMXdLZnJUeDhuelZXS2tpUTNXNnhXSkhYMXc3dHVSNnRi?=
 =?utf-8?B?L1NxZUdJRDBtYXFWeFBEWXd1WnZJdmJId3o0ZHhZUVhRSTVHZlFRSytBR1dP?=
 =?utf-8?B?aGlCaVZSZENiV3pqRXdmRDBTeVNQMFB5V1phUjR5UE1pajh3bGszell3dGNi?=
 =?utf-8?B?emRYVjhLak1LK2dDR0s3bUIyYmthVHdETFlwczUxVHErYmhtdnBjbjNtZDdT?=
 =?utf-8?B?amNKNE1iTFkwbW1JWXpRV2ROeG9scUREK21OTHRoS1F2cFlPOGFlZjMxVlVk?=
 =?utf-8?B?THlxWTA2VTk1V05GYlpZbHdGdlg1bHhUUG1ySHdkLzFhK29UQjB1T3YvUjcy?=
 =?utf-8?B?aGdzcmhRL3VrU0lFQTNDeXJmRFo2ckliU1hCaVg2Nm9Vb3hvczRWOFVXejVl?=
 =?utf-8?B?eWRHeXFER0RnV1dMWnVoZzJ6VVpkeWk3MVd3ZzJIQTBQK0E5aUlvYmpYM3VM?=
 =?utf-8?B?YVZWNnlIQXBtNktNem96STRsNEt4L20wblVVcE5OSm9BU0dvQ0N4VjJOa1pU?=
 =?utf-8?B?WGZqUWJJMXpkZzJyVWtvTkNxemF6ODl3T3piYjZNclBwWXRpenVNeERSZmd6?=
 =?utf-8?B?a2RFQ0R3c00wL2grUW9kQlYvRm83K1phNWRTNFdaOFNXdjh0T2x5YlZSdits?=
 =?utf-8?B?bVhpdHVhdENORS9GVVpPZitkb2taRVhvekhvQ3QzSUhRNEZacDBOcXcyL2lO?=
 =?utf-8?B?ZWc0U2g3S1VjdGtZbDVMVE9EMllzT3NlTnhyeHRNTFlnU3lBeDJRRTdadm4r?=
 =?utf-8?B?d01FQjRoamxTcVJEU1ZvMTM0SWZJTGEwMncwYitsMXhwZTFkVXBWUHBPMGxw?=
 =?utf-8?B?T283MkQyWUhkY1ZOY1huTHI1REtpa3FONzh0VUorOXdJak9tYlV5V0J3ZENr?=
 =?utf-8?B?UUFNcjc4bSt3MEdKaVBMN0Y4dWowZ2M2RHJhdjMvejBXVHFrNGdUZTkxWG1L?=
 =?utf-8?B?UzZqS2VkOW1PeVJGYkVZTEhOWU9RVTE5U3gyWTZMT2M2QXFIT2FvcnRWU3JH?=
 =?utf-8?B?Vi9UQkZNL1o1aVVmUVBSSVBhZVFWaGtGQWE4UDhBYXBsVWY1Z2RKTVFzRnpC?=
 =?utf-8?B?bHQvOHZXdHg5NFBMQ05Gbms0UzlkZFkyaS9Ibnd1czdkSmdCZmRoMlZEcld2?=
 =?utf-8?B?SXpqUFNxUDB6Y2VTSnl1TXJzSHU0alJZbFQxMVRZUWFrMEY0NHo5cmNESGNx?=
 =?utf-8?B?bzhDbjZWRWZFTjRDbWhZT0RMREc4cHIzeC96eTIrT1ZqbTRDQjlFQWZ4S1dX?=
 =?utf-8?B?cWd3cnE2WGV4WXBxSXNZUnRybzIxQTZMQ2lvSWFYS2c1MENPa0ZEVHg1NTdv?=
 =?utf-8?B?N3lLRzBvS2xxbHN5L0NDM1F3ajdiRzVDZmtKaTJmQ3RxTk9YOURqU2J0OGY3?=
 =?utf-8?B?TmNrZ3A4cDlKQjBKQVpraGRPZHVSNjRubm5iVXprdlNaNlgzS1hTTU5IZkVo?=
 =?utf-8?B?ZWpxOC9RdnlDTnlOZFR0UUN2b0loZDZSRDIvUmhqZ092SVNoODZZWk5ySEVm?=
 =?utf-8?B?Tzc4dlBtVmtjWllKbDRRUlhBeWtSNytvY1dWUjg3cEw2QmFnd09lMEh3WjBX?=
 =?utf-8?B?WVZ4VWRRRGNSYS9EbHBkZUdNbVdmTmN4amNsdTdtVU5KNldGM3pMNUVyWGZL?=
 =?utf-8?B?NWFwWXBSUWtEVS96ekluTFBaV1Y0Qkp3LzJUUDlIakxYZTVBTyt5RTBRU3o1?=
 =?utf-8?B?NXFHMFN1Z3NIbEYrbjRXVkRIYlh1bU5vMlo5YVlQYnlHdnFEOVNTVVJOd21a?=
 =?utf-8?B?SURWMnlJWG1OUzIwKzRGK3luaU9DTFU0VW4xVmQreE5pa3pMT0hKbWU4M0dX?=
 =?utf-8?B?L0hEaHF6WVFqbTl3eS93MTZ0UWluRkNXWVZvN09BZ0NVWXd1UXhHTHljaWhV?=
 =?utf-8?B?M3lIOHRhVFhhVW5XNzRBcHFSOTI1NjBXbk9hTnhGYUNkZHZDcTN0cVppUm5y?=
 =?utf-8?B?NW96NnlSV2dFUnJmeGhYWTUyZHArT0NDR2FiOHpmQ3F5ck1ZSzlRdmdCV3Ns?=
 =?utf-8?B?WDJUSUNXNyswTzgzbHVlS0VVQVpHNm1pcUFnT0lLbkMyRzJtb0pEcFU4Snd4?=
 =?utf-8?B?MnVlczlyQXRRKzJzdFZwZ0I4SExOSU9Tb2tscEsxMC9vTVN1SWViODQ2WVZt?=
 =?utf-8?Q?ZlurNhn2y39BP5pGxqIw8vPAa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f237b35-b177-4f44-a0dc-08db1f0902de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 12:39:36.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Du+GEIm2wcjIekh1CLWOwBGlsZ5oSXCzC4d6sBVirl+AVGvWsF/giVuuHsNfD3FNMwBwqK/yHXzMEvRxOIStO58CH18BOjSOEB5ZVFF2y64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8885
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgQW5keSBTaGV2Y2hlbmtvLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY2IDA2LzEzXSBkcml2ZXJzOiBwaW5jdHJsOiByZW5lc2FzOiBBZGQg
UlovRzJMIFBPRUcNCj4gZHJpdmVyIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgTWFyIDcsIDIwMjMg
YXQgMTI6MTAgUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToN
Cj4gPiA+IE9uIFR1ZSwgTWFyIDcsIDIwMjMgYXQgMTA6NTPigK9BTSBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IGFuZHkuc2hl
dmNoZW5rb0BnbWFpbC5jb20gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+ID4gPiA+ID4g
U2VudDogTW9uZGF5LCBNYXJjaCA2LCAyMDIzIDExOjM2IFBNIE1vbiwgTWFyIDA2LCAyMDIzIGF0
DQo+ID4gPiA+ID4gMDk6MDA6MDdBTQ0KPiA+ID4gPiA+ICswMDAwLCBCaWp1IERhcyBraXJqb2l0
dGk6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgcnpnMmxfcG9lZ193
cml0ZShzdHJ1Y3QgcnpnMmxfcG9lZ19jaGlwICpjaGlwLA0KPiA+ID4gPiA+ID4gK3UzMg0KPiA+
ID4gPiA+ID4gK2RhdGEpIHsNCj4gPiA+ID4gPiA+ICsgICBpb3dyaXRlMzIoZGF0YSwgY2hpcC0+
bW1pbyk7IH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICtzdGF0aWMgdTMyIHJ6ZzJsX3Bv
ZWdfcmVhZChzdHJ1Y3QgcnpnMmxfcG9lZ19jaGlwICpjaGlwKSB7DQo+ID4gPiA+ID4gPiArICAg
cmV0dXJuIGlvcmVhZDMyKGNoaXAtPm1taW8pOyB9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaHkg
bm90IHJlZ21hcCBNTUlPPw0KPiA+ID4gPg0KPiA+ID4gPiBTb21lIGRyaXZlcnMgdXNlZCBpb3dy
aXRlMzIsIHNvbWUgdXNlcyB3cml0ZWwsIHNvbWUgdXNlcyByZWdtYXAuDQo+ID4gPiA+DQo+ID4g
PiA+IHdpbGwgdXNlIHJlZ21hcCBmb3IgcmVhZC93cml0ZSxJZiB0aGUgcHJlZmVyZW5jZSBpcyBy
ZWdtYXAgTU1JTyBhcw0KPiA+ID4gPiBpdCBjb21lcyB3aXRoIHNwaW5sb2NrIGZvciBNTUlPIGFj
Y2Vzcy4NCj4gPiA+DQo+ID4gPiBMb2NrIGNhbiBiZSBkaXNhYmxlZC4gSXQncyB1cCB0byB0aGUg
dXNlciBvZiByZWdtYXAuDQo+ID4NCj4gPiBPaywgSnVzdCB3YW50IHRvIGRvdWJsZSBjaGVjaywN
Cj4gPiBQT0VHIGhhcyBhIHNpbmdsZSAzMiBiaXQgcmVnaXN0ZXIuIFNvIGl0IHdvcnRoIHRvIHVz
ZSByZWdtYXA/DQo+ID4gQSBzaW1wbGUgcmVhZGwvd3JpdGUgaXMgc3VmZmljaWVudCBubz8/DQo+
IA0KPiBJdCBjYW4gYmUuIEJ1dCBjYW4geW91IGV4cGxhaW4gd2h5IHlvdSB1c2VkIGlvd3JpdGVY
WCgpIC8gaW9yZWFkWFgoKSBpbnN0ZWFkDQo+IG9mIHdyaXRlWCgpL3JlYWRYKCk/DQoNCkl0IGlz
IGEgbWlzdGFrZSBmcm9tIG15IHNpZGUuIEkgaGF2ZSByZWZlcnJlZCBSWi9HMkwgQlNQIHBvZWcg
ZHJpdmVyIGNvZGVbMV0sDQppbml0aWFsbHkgYW5kIG1pc3NlZCB0byBjaGFuZ2UgdGhpcy4NCg0K
WzFdDQpodHRwczovL2dpdGh1Yi5jb20vcmVuZXNhcy1yei9yel9saW51eC1jaXAvYmxvYi9yei01
LjEwLWNpcDE3L2RyaXZlcnMvcHdtL3BvZWctcnpnMmwuYw0KDQpDaGVlcnMsDQpCaWp1DQoNCg==
