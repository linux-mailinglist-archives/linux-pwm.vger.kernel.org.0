Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9D3D5656
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhGZIhw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 04:37:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21462 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGZIhv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Jul 2021 04:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627291100; x=1658827100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jn3lCa50lQXV8x//dJv7/5r0zEd3AEULkuvluHz2WcI=;
  b=D0JvrbaidFd7+lDY+6Yuiwdo8SyZYlm5p3LumHxF3TlozokXbtcIioxY
   YtXjb/GRVYzyjLoFx8PJTQPjgC78Ds+lma5NnG8w5dmDlxs19pyuYF75w
   ChhYKIi2LT4EFOcBCaeQbP495T/G7g1MZb13ESt/lK2o45p5INYbaA9Os
   WgHIV1mSPTs00uEZ1TE6Tto6TsTYJevVSMGLoAnzpc5V/fKstS0Z0LVTb
   QrGuqAMP7T1swqSt7nX6YD8MLCnNWhOMOyds4w3Jsv5RphPAXAtCnQMyW
   300ZTkarwuFrLmjjeVZOToUd2pI/tmzigdMRPjKmPWDf9ZvEpmylTJUnx
   Q==;
IronPort-SDR: 2BjAZhTj+3VwTAAFPLYNL3fhNI1jL/Az0GJ5kAZRBisVv6QYzD96lkS9wA93VaMGGbrqyqA1jH
 MA7iEBbQ/nEczdkpyxvtUFTIKCwI+Ad4IyrGLF3Q6zg0ZPhSnntXLA4KDkYjKk51nPn6leIiMb
 4v1/9hybsFp0gE8D9JkF7YNPUZXfmPMQfo5qq6UhVQSpWkeTmM1YD32PB5iWamsti+dyq112Zr
 a7xuccpuf6oCnHHCPa2HNvhV238O4Oy5aIv3DOs2mGntTmLA/g+5j284w0lHvn6lfmV+VYc+QR
 U38TbujhdnXLqPp+M16I2t5D
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="137508085"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2021 02:18:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 02:18:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 26 Jul 2021 02:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj1bAk1sHaS8XPismWR7UMBrPHowpekNS1Qm3e0rbpySnJmN2VMBQMtApXknm2atjqZWR4n+t92iR5V/4myg8TT9rj6ZLxAKApayulG/D00rodnMA8wju8HS2F7Z9bMtL/tVo6u4ACCYdBGINBViXi3cdhkTT0VyWtPSuHTblt6QRA/NkuRl0bKsdjTiqXE4qKQioWoHwtsyR0xmKrMGSzn7C4GAvU+btFTSPZYbm6ho1qecpNcyKuoj11LE6ukdaxSV0PqmJ1nl2VnkEMVLLQIr/skJjGLToUIOjjvVXGsA2U9YOFelZrN838c47QWuKpC8LUwx4e3bTMgms3qpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNYvxzFePqBinR8G6JW5BFGo6blJpXMBpFH+nKB3sGg=;
 b=Cu1UFVkXwMHIrWPrTeijjYxL69JYWYww1ExlJAC0J6x+bnXqezekhIEuS15b7z7K80s+/ZqZzp9WoHHYLp8y//wOOImTj5Dq0pglsUz5lzbt/yi5lYMHOix+pdz4/Z6vkcEtEo4+l6OMDrXCQLo5di3U9UgqgEXchcqs62BwmAV9ClaQzOAHIWKXRn/KXWg+i8VvZQVEBLOCfRfb/iHoufo9anypuombKn90R4HYYR4zXGetFjMX6FoOfXxaVL9faUd8NeJwRooWyfMaKewOIakXd4Aikja+6Fjc7BFAJoHLpp08/ouXrkcV/dSV38D83CTstArSF6hj+HiboRBRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNYvxzFePqBinR8G6JW5BFGo6blJpXMBpFH+nKB3sGg=;
 b=Q4qLWiIwDMSHc43gUz+CXi/iAn/QpnuCfBsjyalb4DQYgae/dxjfg1KJvme8TGFLcDnO5/iwLpaaS4iGSq60LkcDSFVIa0o/JD7gLGHTzJv9alsUaDulasftj4CurJeSeC+S4eRcuQOLTuyDVM5OlzDBN4Uhs+Qv67AkWZqb2+s=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Mon, 26 Jul 2021 09:18:16 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::619c:afc6:5264:d3c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::619c:afc6:5264:d3c%5]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 09:18:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <andy.shevchenko@gmail.com>
CC:     <wsa@kernel.org>, <sboyd@kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <mturquette@baylibre.com>,
        <Nicolas.Ferre@microchip.com>, <linux-spi@vger.kernel.org>,
        <o.rempel@pengutronix.de>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <aardelean@deviqon.com>, <kernel@pengutronix.de>,
        <Jonathan.Cameron@huawei.com>, <akpm@linux-foundation.org>,
        <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Thread-Topic: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
Thread-Index: AQHXgf8pHY06FI1b/UyQmpkpzohMFQ==
Date:   Mon, 26 Jul 2021 09:18:16 +0000
Message-ID: <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de>
 <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de> <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de> <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
In-Reply-To: <20210723091331.wl33wtcvvnejuhau@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04d48598-70e6-44e6-b400-08d950164d48
x-ms-traffictypediagnostic: DM6PR11MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB407529003CA9ADAA1072622287E89@DM6PR11MB4075.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWOAEkNP1TE9bQoELQMiIMMHAg9jvm1z4aQP92ANCHITbx4NCxriNGuZH0Xh3WDd4YGoVs03rTP3A/FiQgcEHcdpBh6bYLjKFE+GKpkobqwonG5tEAASyPp/zmAuoZlEvxGyLq8oe72m0qD82OTlKcLaEUMr9vdcVxEupD740OlVInAXKpUXnCQUOCL03O1RTl6V0lYQjUWAWTI6he3l8GJwZsn2E25lsrV+/UfZfwsTumiyNtE0YJb+njQ+9BeO3lahMJVpKeC2c1IrpfczdzzqpjwOL3L6uaLg5a8aHnvbr0j23gW/zKvTJZG5/Mai/Le65Jo6Q1tBVS1I0rOIxFoePs+3ZZlLA+vRMdwM8zOIgmqU8/zMBg9jJkzFZ9hPnJHurnvztaeICG+f2gDN5XWzaEbj7WFCvrijeXoPM5Ay+wxUw13l2rmmyt4fOIAIWpxnPT9vHu6iLRyN+ncsvs3cn7ck+SWMf8HpkkARnfKK4rWh51Xit3X3H48Q2xwxsUXGWivDWcqK3K5SwVYzJ1JH0ecj4hx2KmtPetJSGa1JtXC2poSwzsmG261I+3pRyfApIuOcWeaGx1J+cp4JTqsMYMuZNquHjKxmcPMsgKwhdF6rcsKHx/txauhD1teAk90gh5zsYhWYrvTLOZN0plwzGCaIw6AW/Wh94Y5JCs+8vFvEPjGK0p/X0H8tB30+MIMLrij/Ad8kmOoWHLOhff+romMpCW47JNJ/oXwO30YMRt9jHgJcr+Gm6k+INNrWzJB+Pe02CZ0sdvhW3bVjcwT0lqAav0dk7ncWs9ePqaJe62fgXFLiqBME70KW05RtVB9pivWCITkKeE+FbqM+jlONcy/Tef8hUmKYHbskl9GNLhFv2f6MsxoVXVAF6u/vyvgxT4oxAzCtK+KndM/pMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(316002)(66946007)(6512007)(7416002)(54906003)(71200400001)(86362001)(110136005)(186003)(91956017)(76116006)(508600001)(66574015)(66476007)(66556008)(66446008)(26005)(83380400001)(6506007)(2906002)(36756003)(2616005)(53546011)(122000001)(31686004)(6486002)(4001150100001)(64756008)(31696002)(5660300002)(8936002)(38100700002)(4326008)(8676002)(45980500001)(43740500002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ybk2M8lqJRIt5DXObhEwLVoCLIhUO1hH177bHQ1QN9c5DYelHp8Ekpki?=
 =?Windows-1252?Q?XIsjvKvr8o7yJ3r6r6B/LDYDczu4iylOggyHNfmWhTB1Lf7CzgecRqnP?=
 =?Windows-1252?Q?JobiUJrd0e3jV1n6qlLgKKo1eojJ/lCr+hBujQrM+MN82DgyWr0b3uEg?=
 =?Windows-1252?Q?/rFF0GKjfCQEKrnXvhgbf3BIzUlPTmh0bBTeUO4pbqg1fcEK+whZQObf?=
 =?Windows-1252?Q?ZHYkp2EL7+zC2Bh8yna/S9jhaXzZd+OagaGquFjVtpg/eGxl7isy6vRn?=
 =?Windows-1252?Q?bbVdaElwixwpQc0Mw0NdDFFjODb+dRJ72ADVUVb+aXXy6kMIhG6Da0Kw?=
 =?Windows-1252?Q?Hm1KFP6F0LTmQxiBxBDrNd2Ukz79AtkeDPNISugEQco8aLgFj/z51eMh?=
 =?Windows-1252?Q?lmwootUCnamIviOOX2qAIULboLqFpwIF+/I4Nssh2tgW1ZylGEdRBtWB?=
 =?Windows-1252?Q?a3U1n9uwixGzHTHzuYrjMjL8SCeVXnbWqlCA2234D6J/veQzX4fE39nL?=
 =?Windows-1252?Q?8Rawajm2WOfJ1Cx9tAOExTgLRcCCO2IoJetU7t8CqdqbOOQ+LRRBtRqs?=
 =?Windows-1252?Q?xLPk8qSFEEtiJqLn0wh0rmZrfs0YQhDoWRaEShDeBMFOlMVVR1e9MJut?=
 =?Windows-1252?Q?6Wn0wjUCnXltGr2EtH2SMaNiDzEdP1fuo71GF8RWHHh8C5hDct9kQmyF?=
 =?Windows-1252?Q?OlTWGy7Ncf+F16pYXuItJhBea8r5ds5Zb+Vhwzc8EFZc+SdaKaLtK6Cd?=
 =?Windows-1252?Q?LBAtlsgytumJlfrOw8unvWFfVT0E86PPj7/rHkAGb8J3+pWPkvKHyeP0?=
 =?Windows-1252?Q?581sv9o0YI7WFc1NChIzjKTbZSVlImZOkcLNZpkrsa5ePXwqS8lZ/HDg?=
 =?Windows-1252?Q?BuWg2EpscIruLMyVLYdooIAv2hV6Jh8UZ+Z/pI8EtgNoyKYb7DOBz7Ch?=
 =?Windows-1252?Q?gbUGp0DYatebGl8MWOOz6Rd0DegchHQrLxLgkQWqvwU3izdNtX6fxUmS?=
 =?Windows-1252?Q?WD98VHqjPS3nDKnmEYnwmPBeE2nsQpdGReDI/WrG+R69LLGSz5wa+8bL?=
 =?Windows-1252?Q?RtgWpB14K4ilpTx2BF1yoHg06UYRTx3YZZo0e/Xr9M0k7ZO4Em9EEI7b?=
 =?Windows-1252?Q?+rhmWBgE9/BFIP9VEsVj3mnuqDqzuVkyymECmtjJrrO4JPwqUQVXrOV4?=
 =?Windows-1252?Q?5Vz/CRb/95UUD0/pkVPvPnH6zZXdvm8D//KvE7iQcMUbYIC55++fu4Xl?=
 =?Windows-1252?Q?AWDL5pniNZwr5DmCnDGs5dbY+vXiXZOhDozlTIkqsnaZEFiurG7riSex?=
 =?Windows-1252?Q?Oj+mueve+XCAMb73tVoWVVg6GmsyO63XeKebcnq9LE74RzNioDn7yZeE?=
 =?Windows-1252?Q?K/GZEOoMhZaxZN/oB79i4VdEPl4s63tPiCw=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2EB1600D5387994EBEA2785CF265B011@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d48598-70e6-44e6-b400-08d950164d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 09:18:16.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWOz8+d7+fQpkgUc8hqaiG61U0SCix3gjeDu4lNUG/TyJ2F92jo9AdSavtEOok7hqFz+pIzthUoq3Dy7RK4j+Fz5lhjjsvPfUfIjNezpNo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23.07.2021 12:13, Uwe Kleine-K=F6nig wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
>=20
> ForwardedMessage.eml
>=20
> Subject:
> Re: [PULL] Add variants of devm_clk_get for prepared and enabled clocks
> enabled clocks
> From:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Date:
> 23.07.2021, 12:13
>=20
> To:
> Andy Shevchenko <andy.shevchenko@gmail.com>
> CC:
> Wolfram Sang <wsa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
> "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
> "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Alexandre Bellon=
i
> <alexandre.belloni@bootlin.com>, Claudiu Beznea
> <claudiu.beznea@microchip.com>, Alessandro Zummo <a.zummo@towertech.it>,
> Michael Turquette <mturquette@baylibre.com>, Nicolas Ferre
> <nicolas.ferre@microchip.com>, "linux-spi@vger.kernel.org"
> <linux-spi@vger.kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
> Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown
> <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandr=
u
> Ardelean <aardelean@deviqon.com>, "kernel@pengutronix.de"
> <kernel@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
> Andrew Morton <akpm@linux-foundation.org>, Lee Jones
> <lee.jones@linaro.org>, "linux-clk@vger.kernel.org"
> <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
> <linux-arm-kernel@lists.infradead.org>, Linus Torvalds
> <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>
>=20
>=20
> Hello,
>=20
> [adding Linus and lkml to Cc: and adding some more context]=20
>=20
> On Wed, Jun 09, 2021 at 10:21:23PM +0200, Uwe Kleine-K=F6nig wrote:
>> given that I don't succeed in getting any feedback for my patch set, I'm
>> trying with a pull request today.
> This is for a series that is currently in v7 and didn't get any feedback
> at all yet. The history is:
>=20
> v1: 2020-10-13, https://lore.kernel.org/linux-clk/20201013082132.661993-1=
-u.kleine-koenig@pengutronix.de
>     no feedback at all
>=20
> v2: 2021-03-01, https://lore.kernel.org/linux-clk/20210301110821.1445756-=
1-uwe@kleine-koenig.org
>     kernel test robot identified some issues
>=20
> v3: 2021-03-01, https://lore.kernel.org/linux-clk/20210301135053.1462168-=
1-u.kleine-koenig@pengutronix.de
>     I added a few driver patches to show the benefit. (However in a way
>     that the autobuilders don't understand, so there were some false
>     positive build failure reports.)
>=20
> v4: 2021-03-30, https://lore.kernel.org/linux-clk/20210330181755.204339-1=
-u.kleine-koenig@pengutronix.de
>     Got some feedback for the converted drivers by the respective
>     maintainers. Some were indifferent, some found it good
>=20
> v5: 2021-04-22, https://lore.kernel.org/linux-clk/20210422065726.1646742-=
1-u.kleine-koenig@pengutronix.de
>     Fixed a problem in one of the driver changes (i2c-imx), no feedback
>     apart from pointing out a few typos, silence from the clk
>     maintainers
>=20
> v6: 2021-04-26, https://lore.kernel.org/linux-clk/20210426141730.2826832-=
1-u.kleine-koenig@pengutronix.de
>     Just the typos fixed, no feedback
>=20
> v6 resend: 2021-05-10, https://lore.kernel.org/linux-clk/20210510061724.9=
40447-1-u.kleine-koenig@pengutronix.de
>     no changes in code. Got some feedback from Jonathan Cameron
>=20
> v7: 2021-05-10, https://lore.kernel.org/linux-clk/20210510174142.986250-1=
-u.kleine-koenig@pengutronix.de
>     Adress Jonathan's feedback, recieved some more acks from non-clk
>     people
>=20
> pull request: 2021-07-09, https://lore.kernel.org/linux-clk/2021060920212=
3.u5rmw7al4x3rrvun@pengutronix.de
>=20
> On Fri, Jul 23, 2021 at 11:26:58AM +0300, Andy Shevchenko wrote:
>> On Thursday, July 22, 2021, Wolfram Sang <wsa@kernel.org> wrote:
>>
>>>>> What about adding gkh to the list explaining the situation to him?
>>>> Greg doesn't like devm_ stuff.
>>>>
>>>> I already asked Arnd who doesn't want to interfere and akpm who didn't
>>>> react either up to now.
>>> Wow, okay, that is frustrating.
>> The situation simply shows the process gap and One Maintainer nowadays i=
s
>> far from enough to satisfy demands.
> Technically there are two maintainers for drivers/clk, Michael Turquette
> and Stephen Boyd. It seems Michael is MIA and Stephen doesn't have the
> capacity to address all requests.
>=20
>> What I think about is that we need to escalate this to Linus and
>> others and elaborate the mechanisms how to squeeze a new (additional)
>> maintainer when the original one is not responsive. Let=92s say some
>> procedural steps. Otherwise we doomed because of human factor.
> Assuming there was some process for this, is there someone who is
> willing to take responsibility here?

Hi,

In the last year I worked on AT91 clock drivers and I would be available
for taking responsibility beyond AT91 clocks (if everyone's OK with this),
in whatever form the current maintainers and people in the audience would
agree, if any (co-maintainer or other forms that could be useful). The idea
is to help things progress as I also have patches waiting for feedback on
clock mailing list for almost 6 months.

Let me know if I can be helpful.

Thank you,
Claudiu Beznea

>=20
> Best regards
> Uwe
> =20
> -- Pengutronix e.K. | Uwe Kleine-K=F6nig | Industrial Linux Solutions |
> https://www.pengutronix.de/ |
>=20

