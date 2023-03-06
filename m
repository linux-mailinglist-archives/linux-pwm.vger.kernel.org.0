Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40F6ABEC4
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCFLxR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCFLxQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 06:53:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB621A5D3
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 03:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678103594; x=1709639594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mcp2YGjixn5mknZw1P/raq/JMkC3eNohuVlHRndwgKI=;
  b=nGDrttzTmX7R9wkSP0RgZMA8x6JgoqFBqy03qBUlqp7rBFzJfKVyqh5Q
   fCRXUc4nYOOLz6ZJL0U3r7wRkSGBC5/iOXoZJSxVKm+aq9gdkZT/SF1AN
   HEE7i8dvLgv8nvD+wch7iKMnCtYmtXUBDN2PNjppqlHo3sH96ODAyqZUX
   VV/nbn7rnUYeMjYUpbzM2E4Ub+TvwE8mnKeEZU12iZeU9eO236bF0ls4j
   HhV9+Hp8XVBkcKhRTG/sXPjwTUM+Pa2pMyabtTgfM7jVKKAE5h/a/Hxc2
   RhKaKNTNCoReVsbfomQwB4C8mmArCc4bE1KwcQ383oE5BFjPFkQTMJwlv
   w==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="200114058"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 04:53:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 04:53:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Mar 2023 04:53:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSzUKAHYQ1mOhGFD5JwqdS7YXCwMLfEtpZh5xrb6wKvPV7kuP2okoo6ohLh3Ctwxw5QrFRORwRmd8/h5TMLovbJ9mR0OPNnv4ZlK0cVtsnp5QecciU4I3IZEcjclKYnlUhW8f2MVTMr+aNrjFqiwF7zDXqDHdsit9FOIERWyTd3n+NpAxu0JPbPzkPlO0w+Ec5JVQOT1Tw7gLcG5m8qdU0MJO0hEXEMquuJmb+IsouP4XWzDDC7sFnLumxiOaPVXktxXmQGSTCYO91QMRX1j7Y6nhfOND8TZSIEjL82jsCU293bhAVPhJRUc+18FKc/QtotGWKdxbr0hHkDwkX1E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcp2YGjixn5mknZw1P/raq/JMkC3eNohuVlHRndwgKI=;
 b=TMCslEqJUhaInPcafyLO4MMgCC/FpJukguA40go4rH0ft/766ky69+gtUNpr+Nss2/T8q5C1neNwIpuLOdbWEZboc4VMljdfovo0axU7yXqYvYkbiFcTf7XJxuF3+XGjf+iw6igsuFr3mYdLL343PH36LJbfkWC/cEBBf9DwhaYwHYcnL8R5RlFKl8HBsGDwodn1DsuL1C1MyyIGAI8zdPi0aSq95FqA3PxohogxUUA4NINUkor63C8sDPMX8e+lH1JeXtXA4AtojMp2zPdMvfVrFUAele9GGylRQzPlJwHsqJtlhWhef6EVHt6Gt5gR+bnuD9iYXpGgdlcRK06o0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcp2YGjixn5mknZw1P/raq/JMkC3eNohuVlHRndwgKI=;
 b=Uw9YlUh3xMmNYdwa3Lgd383EdYgwHNBPRjfGobL1ijCsJkoZD92GWMFSFPygKJEARoeq4lCQ5SgAfa3OlH5/pZPbDqOvroCCJIXInujmYp6bPFtv7o2sI+UC6nyQ7s6rUP2nEzTUh5CPBYUKhQAGu8mwnQ4iQ34xGIPffv7erlc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:53:07 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:53:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <kernel@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/30] pwm: atmel-hlcdc: Convert to platform remove
 callback returning void
Thread-Topic: [PATCH 01/30] pwm: atmel-hlcdc: Convert to platform remove
 callback returning void
Thread-Index: AQHZUCI3n+gnfYHV2UCeAXKStn2g0g==
Date:   Mon, 6 Mar 2023 11:53:07 +0000
Message-ID: <10ae0087-411e-e2c5-64a2-629b8fc77d8a@microchip.com>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
 <20230303185445.2112695-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303185445.2112695-2-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5557:EE_
x-ms-office365-filtering-correlation-id: af7076e2-902c-4824-c699-08db1e3959e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I89jmmKDyR9z6ZlQQ6ABwT+Pfd9NFCJbPtd/QtciTlmDVUR1QwByirBH9aIcNair4rhs24UDvrD3XxqRlsY4UJ5cDqk07TZQy3FYOOm2HMhFP+zlmMF7Cftym4BZXrVsFvy6uXnuex4hKdjXA0XKElKM67Fa8SbRAdWNhGtw6RYB3N0ROWO2cO7bdrLpXZ1GcTlq+ir8RICCURfwXWT5o496Uv0g/063C3gChBZgOJwDt0U2+AB6Sl45kwmDvIilw1SdXSIvNjc062O7EzUHhnPqzleXXo72Kag/kdfF25LXC1Fr8LaIPuYr/XMoo9PIstyRBzhYNJX/UjYm1oTpTwwapkTxRpMe7pSB/n3ki/QtjKCzowE22OUynxtY9UmIQHfufONQmv0bfxQIa4qTaxTloLnWCqUUCsZaNu/QdlEBRQxl+nCruR8WN91IkhFDDa4c2cXwO8i7JjB5CVFUDNOY6wMBIlJA4i5DDncakchuQHGVYq954UrFZ6ZDpipV66Qcc4Gkkwax1zvHDBDMszK/YO/sEFim+f7/PUupuS9AN/lZ5IrCu04SNAKbdhYSouIqV7E37Ifc76+jTDTZ70HCyKxnL5wLylzbbwo3RD+JrUT94rFRJMvwTgrgfc0gOCeHQqdTAABUOk+O7GcMZZwiMy0KaDkv/c58iZJ/tFawZ8eyR5sU1BIdxXGO8HcWp5b1Y90Ok2na6TCpwK3BCkENXGv+1mfghaDaJCIrrrmRzViOOYc9EMpINlwW9AjRhWnYmP38e81b+ru7EMxauw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199018)(6506007)(6512007)(53546011)(6486002)(36756003)(38070700005)(83380400001)(31696002)(86362001)(122000001)(38100700002)(186003)(26005)(2616005)(41300700001)(91956017)(66476007)(66946007)(66556008)(76116006)(66446008)(4326008)(8676002)(64756008)(2906002)(8936002)(31686004)(5660300002)(71200400001)(316002)(54906003)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFQvaFAwMnVoUzRibVNWUnhRUFVKanJ6a2tPemMxUU1CaEpCTXB0NGdrVkZJ?=
 =?utf-8?B?UHVYa0pEeHNaYW5aMllCWEN0ZnlxbUFxOFhKckdDcDhCeDM2UDh6YngvU0Mr?=
 =?utf-8?B?eTMzM2tWTUl2N05SOW12bzhiOVBmeFJ5T2VCZ0F5WmxBdW02NWNJT29Mckl5?=
 =?utf-8?B?RnlINXlqaUQyeURQNloxaFZmclRIU2Y0RyszN0ZlWXhpSEFJeGNCY01uWitR?=
 =?utf-8?B?aHduUVVtMU50ZGFiMEJkVjAxY2I2aFhiNXFZMncwMG80ZFhZY3A4cmM2Rzlm?=
 =?utf-8?B?cGQ5WEtmdUhnQTAxcE5mQVJueitoN2ZrNUxLU0pPNGkzVVNlc1h6UHdnWlhQ?=
 =?utf-8?B?d21TSnFMTXo2SkFtRHo2Y3RTaXhsZjBwUm11UUppR3Iwa29KMkZ4Y2dtZTV0?=
 =?utf-8?B?eUNCMzdWSWRZaHp0UWh5RlVyZGNiUk9rdk1LRnVqa2RqTGZ4Qkx2Z04wMkFk?=
 =?utf-8?B?aURrRDF5UEhHbWhXRHowZFNyeDlKbk5wd25aU1RDL0t6ZTd5eG0wbHErZDZJ?=
 =?utf-8?B?OStmUGY3OEFCRVF0YTN3NEJJK2dmdm43ZFI3NDlZSTVxajZaWGtYUC9QRWxG?=
 =?utf-8?B?WFdwcU15T2tMUGZtUWpLZDBpUEJ6SGxJVCs3dy90QTVFdW14cm1DeTBRcmJN?=
 =?utf-8?B?WXJDcCt5alJWT1hPMlBUL2c3eVptRUtxdnpjVmU4MEtJWEhZcVFEa0VKSTNP?=
 =?utf-8?B?WUVKSW9RQzBzSWZTV3ZNWHh2bGNtQXdaVS9kN2hxZndGYUk2cmxwZkRyUVpG?=
 =?utf-8?B?ZXpNNW9WTjB1ZUY0NzdjK2JPY29JNDkyenhkdTZhS29xMGJFNU1kaElrT1g4?=
 =?utf-8?B?ajZaNzJLZ3F2RVd5OFc1M3VFSVovYUxzMEFIRGhHTVMwVjBvMVZmanNGYWhs?=
 =?utf-8?B?MjVlRThCMmlWdDZPVUVFQzc2a1lENy9GWDJtSXhoZEpMbS9TSDgzM1dOOE5o?=
 =?utf-8?B?eUtUYjFGc0ZOVS9jUmhFWk9ad0kyWUMrWGpiTlp2b1E2amFxWUZLaE9uSGdn?=
 =?utf-8?B?VWRyRExnNWFkR0VCaFBQM3Y2NEJqSG1oYyt1b1huOHJyZ1pvdUlwalNUZEJs?=
 =?utf-8?B?blVWTVBNbUJHbWd6RkRtQUVPTUZtYzFwalBVeHdUVThjNzZINCtDWURMMFBh?=
 =?utf-8?B?MzB1cFpaT2ZIcGd5aGloRVJEMzl5T3BMZi9mOG4ybUE0UWZxOEYxSkNTSlVo?=
 =?utf-8?B?MWtySzNoNVh4VmJzb1JBeFJFOXJad0FlRldDK3AycjJOSEQyY1RycTRvQjF3?=
 =?utf-8?B?MG1QY25tTWlGNzhyWm0xeHVVdzlSelljeUVtVmtkWGhHSFV1WEY0NzhsQ09t?=
 =?utf-8?B?WHZuU0c4SXE0dXhFYVJRMzU4clAxS0lwZVlINU9xVmRSK1FlQldRT0JFYTlQ?=
 =?utf-8?B?aklVZGE2Unc2WW5sSGdCZ1hzd2RrZnJxRi9ZS1NvRFNTb3l0RWdtQno1a0Y1?=
 =?utf-8?B?dklqN3pFeGNTamxwaUFMb3pxSVFiSFJMYXg4NmdzdTIxd2dFcm5wcDNyQWZZ?=
 =?utf-8?B?REtDZDFZRkFtRnNUaFVia01LUjZKSXRKakEyaEdwMkdTaW5weXBqMjQ4NXJZ?=
 =?utf-8?B?SUFSQ1FyY0REUTBMVGt0ZHpEbTdHRVBGZzRUblpaRUsxTkF5TG1rc2gzcjh6?=
 =?utf-8?B?Sm45TlhkTW1qVlhoZDhHM0txeWdza3ZwdGdremZQYnAxZkM3NEhnOUg3djNt?=
 =?utf-8?B?UlFFR21WME1xMGwrdzlYRUlLTElHQTNXNlNweVN6aDh0WC9xSEpPRW9QN3F5?=
 =?utf-8?B?MHgzUllUUnJCV3ZrVnNyVytwRy80MFBSd2xuelE4STVJUjhkcU1VZXRDaXht?=
 =?utf-8?B?YjR2eDUydU1FZG1PSy9FMkltUTlSOEwrM3N5WSt4d3JFbjlsVDFGRFpWTXlm?=
 =?utf-8?B?QzE0by93aTh4Q01rYzVuK0l4RUhETVBsbG0wNXlhTkpwcW1DK2E5b1VRMHR4?=
 =?utf-8?B?TElrTzdZUTJhS1pFZlJTT0lGZGIxZVgwYTRqQ0lzR2xDQm9iY3R2ZW5ua2xH?=
 =?utf-8?B?QjJRdVQycCtxd2daWTdPZG5TUFVEY3VZOHI0WEYyMTJBcHhTNXRUT0lBbnlK?=
 =?utf-8?B?d21ySTBRbkw2VUM1NEpsTzNuSVowaERqS0F0WFJvK0JXZ09IbkY1QWtNbmN0?=
 =?utf-8?B?a01KYVFRV2h2QWJDRzNVVGhTUUVVeCtMbHZiMFZCZ2EzNWhhUTJaZ0dweFhG?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <392A38B799712D4A9D9B8E765B48E0CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7076e2-902c-4824-c699-08db1e3959e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:53:07.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alkFa6U9ZnbQ1hjmxtNqYnDqXRh5aJ3bX3phbu3lnMrLwtd5BkZabx9L9w3xnAgTdx7Nui3fldnbfakzIflWXRCTRPA+z5cVHTrx5cOMHTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5557
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMDMuMDMuMjAyMyAyMDo1NCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIC5yZW1vdmUoKSBjYWxsYmFjayBm
b3IgYSBwbGF0Zm9ybSBkcml2ZXIgcmV0dXJucyBhbiBpbnQgd2hpY2ggbWFrZXMNCj4gbWFueSBk
cml2ZXIgYXV0aG9ycyB3cm9uZ2x5IGFzc3VtZSBpdCdzIHBvc3NpYmxlIHRvIGRvIGVycm9yIGhh
bmRsaW5nIGJ5DQo+IHJldHVybmluZyBhbiBlcnJvciBjb2RlLiBIb3dldmVyIHRoZSB2YWx1ZSBy
ZXR1cm5lZCBpcyAobW9zdGx5KSBpZ25vcmVkDQo+IGFuZCB0aGlzIHR5cGljYWxseSByZXN1bHRz
IGluIHJlc291cmNlIGxlYWtzLiBUbyBpbXByb3ZlIGhlcmUgdGhlcmUgaXMgYQ0KPiBxdWVzdCB0
byBtYWtlIHRoZSByZW1vdmUgY2FsbGJhY2sgcmV0dXJuIHZvaWQuIEluIHRoZSBmaXJzdCBzdGVw
IG9mIHRoaXMNCj4gcXVlc3QgYWxsIGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0byAucmVtb3ZlX25l
dygpIHdoaWNoIGFscmVhZHkgcmV0dXJucw0KPiB2b2lkLg0KPiANCj4gVHJpdmlhbGx5IGNvbnZl
cnQgdGhpcyBkcml2ZXIgZnJvbSBhbHdheXMgcmV0dXJuaW5nIHplcm8gaW4gdGhlIHJlbW92ZQ0K
PiBjYWxsYmFjayB0byB0aGUgdm9pZCByZXR1cm5pbmcgdmFyaWFudC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+
DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wd20vcHdtLWF0bWVsLWhsY2RjLmMgfCA2ICsr
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYyBiL2RyaXZl
cnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQo+IGluZGV4IGE0M2IyYmFiYzgwOS4uOTZhNzA5YTlk
NDlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYw0KPiArKysg
Yi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYw0KPiBAQCAtMjc4LDE1ICsyNzgsMTMgQEAg
c3RhdGljIGludCBhdG1lbF9obGNkY19wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IGF0bWVs
X2hsY2RjX3B3bV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3N0YXRp
YyB2b2lkIGF0bWVsX2hsY2RjX3B3bV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgYXRtZWxfaGxjZGNfcHdtICpjaGlwID0gcGxhdGZv
cm1fZ2V0X2RydmRhdGEocGRldik7DQo+IA0KPiAgICAgICAgIHB3bWNoaXBfcmVtb3ZlKCZjaGlw
LT5jaGlwKTsNCj4gDQo+ICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGNoaXAtPmhsY2Rj
LT5wZXJpcGhfY2xrKTsNCj4gLQ0KPiAtICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX2hsY2RjX3B3bV9kdF9pZHNbXSA9
IHsNCj4gQEAgLTMwMSw3ICsyOTksNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBh
dG1lbF9obGNkY19wd21fZHJpdmVyID0gew0KPiAgICAgICAgICAgICAgICAgLnBtID0gJmF0bWVs
X2hsY2RjX3B3bV9wbV9vcHMsDQo+ICAgICAgICAgfSwNCj4gICAgICAgICAucHJvYmUgPSBhdG1l
bF9obGNkY19wd21fcHJvYmUsDQo+IC0gICAgICAgLnJlbW92ZSA9IGF0bWVsX2hsY2RjX3B3bV9y
ZW1vdmUsDQo+ICsgICAgICAgLnJlbW92ZV9uZXcgPSBhdG1lbF9obGNkY19wd21fcmVtb3ZlLA0K
PiAgfTsNCj4gIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoYXRtZWxfaGxjZGNfcHdtX2RyaXZlcik7
DQo+IA0KPiAtLQ0KPiAyLjM5LjENCj4gDQoNCg==
