Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC26ABECE
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCFLyH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 06:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCFLxo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 06:53:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22781193C2
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 03:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678103612; x=1709639612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBUa52+hGAN7to+7nAlNvNbbN3sEznL2ZLNVTfQi3i0=;
  b=HaZOTvtsNMM45c3sbQoxZiEGcHO0kRYJIRP8fBUEV35Bnq1gGGMNZkx0
   3rAAdMr8lwen/62XZEa/l+gDSOu4Fx/6dctBlYV9TDFh/j/2vjHhiVa5B
   va7Twy82AJXDunP2/z3ckvVbITCZfsnUavV9BVoQwpQOTOBxnRKylTiWQ
   8d4WMEFZHx8bnJU+Ir5ckKw7B/zDUOMKgsrV8CIU8WxRWlbJS565bsUE0
   kHfBlCKA6UWujhnHmPllINyiEiXR2CJG3nKtZjVqDS2J7syrrT4Zb4AoK
   kyqce4fR5A7lubRL0axSGJBzwPGPzjkhylKrJ9ItHyu0ZUxPd43ffw3x8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="200114122"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 04:53:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 04:53:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 04:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPWdL0ZxBtbxHgv7Qu7u9yliykRxAghob3WEWJ2Qc9YQojmekwlcjwdOr8tERM0cGNRZtebepD8SfqkVs0qnBFUfee5psg5EG8o2aUqapn2sqpeEksOSiorQbFlroqvIxRIEjErI4JTbI+rnDs3q63viJUYfu5Pj/KTaL3Av/d3cksKqa19y1C71rEyUHiiQ83i3VbziT5M2O7OG/qgyHJivPtv8c4D1lOYUxDgiLTprk/HHdWLrKM/0SECofEScKXPdjR0eD8DF/DxpNABc1wM/82KYnUJ9tZETJ3LlFfDA0aw78T5wlt3KKrfaCx2xLXJFy1Pa+mL/h/MjzVqWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBUa52+hGAN7to+7nAlNvNbbN3sEznL2ZLNVTfQi3i0=;
 b=UkKfW81dVLauZa1rzB1BUTTnIuzdruLVfX9oxTiy57GpadCokr9Jh/bYJFSMJY4ybK32DBYy0bs3owjubbKHm3j9FkaGzCrDlMFP+/mHwYZ6oDFw6Vfo688Sy+mz5F/RgkErzYTyDKfsJx077cqO5EtMMxh6+Q4HeObMNNrQSCcEXcAPVjeEBhVoCT2d+jZWFCXdDPJ3BKDY7briJCcpvh+g4cBrjPUU3MQurpeyisBWAPhSGBi3o1T6PPnCvM4gGmIJOsywYe6H6zl/OhQwVahFbnmHgl+Yo2c+a1nEc6vlQQBcBUqO0fl62096v+s75X/huV4tPz7tJfWSHCEtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBUa52+hGAN7to+7nAlNvNbbN3sEznL2ZLNVTfQi3i0=;
 b=OD1iaYtzVnMnHDq+XYCBh/qKYzMoMNIHY15ytDjS5onepEgRjMXRsdmyBujfPvuC3rVsl99m2F9g3t6EjqgwNS9TgmJoSbgqIHZfw8ZPk+OqZsVmM8f/cAnNbfaPY97yGd8YDWSxSx8k0bvxECCBhz42cG0ft9cd0CfP4giuvy4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:53:27 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:53:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 03/30] pwm: atmel: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH 03/30] pwm: atmel: Convert to platform remove callback
 returning void
Thread-Index: AQHZUCJDSqitBJqfAEuUYFWgamvIZw==
Date:   Mon, 6 Mar 2023 11:53:26 +0000
Message-ID: <769e4d74-db60-9e33-d0e4-6ae45308d0fa@microchip.com>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
 <20230303185445.2112695-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303185445.2112695-4-u.kleine-koenig@pengutronix.de>
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
x-ms-office365-filtering-correlation-id: a089b6b6-37c9-4e28-1e52-08db1e396597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1zTW6YtiobfUIAgHkcG52Z2fKHmS6JR3+/i6Kvz/MtTTIylC9k9h6O1iuGh7LZe71n+HA7Qb0zgj69ZrdjveHS63aAbonop3iYZqTA0k+Zbhs666aNCD6qyQLE53uK8vqhgyzmWqfXf8qfhz5shWzN2dL+s1E1JuwgOKyBQoS7VKomp2WGGPCI4c4U99QxTFzEQcEzDPzkaFQqvUX816USvFL2pDMdGq0vDCtsGpCcSyrOw7tUq2kcq1iPkldQ4PUVrBCZxnB0Z8zRHdW0xb5zjU4wc1aL4n+grL4OHLPkkrNi6BZwoWi/rpzcLw4P9CGb9XatFC4WEdOoI5RxwP6sDnuh6pZfq37KQ7vEhcCV9++S7+W4SxawMY11NxCKxAwS4DU1Tzwjrcd/i2QBttHOBNB7sQqAYaGyquoUVeXeA5yx6J8iN5WzCpqc75wLWGQvXYtlLtFjvi9Yv0SOJvBOjhQr44cl2caT554JAm/u7J3ux59PQl/+mtK9EjUK2M5JYKCoKoqJbSeylWJzSCF8RsMG2mOk7nzBRo6lKztcRIQJjJ2BEzgvUjhxs6jHokQowsqPSZz12WXzP13H1P790klv2xq17SsZJGf50TP5Rh/mcmXIu48c6siFtrBR9XVOi/dntPcWOTmWsYPejeUOyBGR7cDIvkNuUf/IqBUAD9K5vFPRGFCJBZrxTIioYjsDUs1K/eyssnVsTbTfEbqw+ap+kh0nAZywemwhRTBowXMDTo/BgFrUgzNPPdfgV1STEg6k2mvJg66z62/0zfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199018)(6506007)(6512007)(53546011)(6486002)(36756003)(38070700005)(83380400001)(31696002)(86362001)(122000001)(38100700002)(186003)(26005)(2616005)(41300700001)(91956017)(66476007)(66946007)(66556008)(76116006)(66446008)(4326008)(8676002)(64756008)(2906002)(8936002)(31686004)(5660300002)(71200400001)(316002)(54906003)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MCtQcE1rVHNKYjd1QUlYM0hxOU5qVGFRc3BjMjVISVdjeVRQQTdWeWpZQ3RJ?=
 =?utf-8?B?ZmJYZUZ1R2N1dkx3eXg2STZMdmJXS1NKbDJTK05DVjk4Y2hQbEJ3bUYzNWJW?=
 =?utf-8?B?VTNZOFo5L1NHd05KMGhKbGxobm1ibExNSkJqRTZOaURCb20xSUpNMXNQMWVH?=
 =?utf-8?B?RmV1ZWt1dGpxbkxuUUFyMkxiczA5c0dKdUYrWXpCNjJqd3FmRUpOdEhaV2VH?=
 =?utf-8?B?YUZ0cm1CSWV6b3NCMEsyMDRLaTJpQzBYRkR0Q3hCdFRLd044RzVqSkVpVS9J?=
 =?utf-8?B?bmZKejJvVnhFc0xXNGlzZFpERGErMGxYbFJwK2RXQW9DeXdobktmWS9tWDZs?=
 =?utf-8?B?dXNNOWRrMklaODhPb1FUdGtCYi9hR3YxajViZllSN29xR0l6RUdNU0wyenNl?=
 =?utf-8?B?Q3lEUnRnSmlPUmFqQ1ZPUU5SREhmdmMxQkR0djNkSC9WdUQyQ3NrN2pkRFJG?=
 =?utf-8?B?REZGei9Kdk43SzBJTVJ4Q0pQQ3hqaXVWMExxWmxZa29EeWVqTktaa29kS2xM?=
 =?utf-8?B?bFZ1aWNZcS9BbkJuVjFFR05ORkhmR1JFSlE0VVRMZHRQNUVwZk1HcHhlcjRH?=
 =?utf-8?B?YWFsNWNHdldXRVJQTTBjYmxKazFPZHJGVWNReFlLbDFlekVkeXpSNk1TVS9k?=
 =?utf-8?B?RCtYSTEvVHhtUTNEZ0ZONCtOU0lWTDlLUmpvSjVhdVROSUIxZFF2OFlYdVkz?=
 =?utf-8?B?ZlliajRGZTBJaGhIWXJxM3FvSTdlMkdsK3kzeWRxRTU0VHlaRjZ1eXR1OTBw?=
 =?utf-8?B?OVNDbWRHTms5VnBXTUw4dzV3Q2V2cGVUMTZNTEZsTkZjNEtFbEwxdzdhc0Np?=
 =?utf-8?B?WURQaWkwL081bGlmb3lkSHFvQnZyK0FKdDV0QzV2Ky9QT2ZYVHhSL2tZNExq?=
 =?utf-8?B?V3BzSEN6UTVRTHpXOTVLK1E4VitOM3gxdVkyMzRoelJSMGp0RTcrNE04Y2ZV?=
 =?utf-8?B?c0QyQ1ErOXgvTHIvY3ZsT0xSc3h2SzEzenU3L0RjeVpIT0Ryb0RMWlZrTmpa?=
 =?utf-8?B?alg5OGx4enJrWlM3WGZQSVZSOUpRUjFldVNwNHJTVEp2aHltNFltWldGQkQ4?=
 =?utf-8?B?NHVvNFVmVnRyeUIrcjdBQVA5UjZWUVdEMlV4YWZFWnhDUGs2anZtN1UxRHJP?=
 =?utf-8?B?ZXRqOXVGVDdVNnI0YlZlSGVyWXBLWEp0TjQ0RGtmaG1vTVFPeGdvVjgyaElr?=
 =?utf-8?B?Q1gwNE4xbUNKNFpIOVcvVjNacHV1L0ZudlZLWkVEYm9iejhLS1VUZk1SWHZN?=
 =?utf-8?B?SUEwOWhHcDIxSEltRTk0QzFuS1djTWpoaElEVDUrZXBCSkZQM0VFWnJiRlda?=
 =?utf-8?B?TTVJSXFjK0JSMER2MXZMWjhCY1ZQSFR5YUdDTjhHbjRFZ2JTTXg4NjA4aW42?=
 =?utf-8?B?aytMWXpoZ0NCbjVrb3VuZHNEL2JCNm81S3ZqQm1pTFd1MmEzMVM5cFhIeXJt?=
 =?utf-8?B?MThuZGpZeVVCOUsydW9mOTFnYldoSm9nSUU2MmIvVVlYRExoa2tDM1dYdWcr?=
 =?utf-8?B?bWFrZTRUVjRvSDhSWitndlpxMGswdlJSVFhkNGx2MVdYTmN3Q1cxS1h5bWlV?=
 =?utf-8?B?WkpYUng5ZklqUi9XSFQ2WmExejhlN3lwWlZ4ZitxRTAxN3B3Z0NJUGhTYzRQ?=
 =?utf-8?B?M2ttQTFjdGtjZ0hTaXhnZCtiZjMyK0N2b2V2UDZuQXdUVnREbS9ld1FlYnBa?=
 =?utf-8?B?TGJVMWV2ZWpFTENmNnBydmJaNmUxenBlWVMxbE9PUlNQMVk1ODZKd0s4RU55?=
 =?utf-8?B?VUg5eXo1aURhOUx1R2x3UEJTUVNoR1lJSVJ6VWU5aVFTaDhTekZRc1VUSDUz?=
 =?utf-8?B?d0tPb0Z4V1d3Y3hTbVd4R25vZEdMai9PVGZ3VHJSbXVtM3A5SC9zVnM3b2hS?=
 =?utf-8?B?RTVDTTZZOHRsZWhQZkptMnRWeFpHR1lGUTF2SE9NNklpNWk3NHBsaUMvUWpI?=
 =?utf-8?B?V0R0WmlUWHhOY2czeWh5ZUJPc0ROMkIrWkFLNnhudG9zU1R6dXljbmh4M2Vj?=
 =?utf-8?B?QUNvbXVzWDcvNmdTYXRGWFFlSG1lSnUwUTBvNys0Z2gzRU5IMXh2RUZWNmtF?=
 =?utf-8?B?WWh5anBJTVNhU3FPbEFsMFdOeWp4ZmMzMnozd2ZYQVJXaWo2Z09NenV4b0lG?=
 =?utf-8?B?cnExSXRITGRKNFIrQjEyYlAxSzJoazdtS205dFcwRUFQdExkbGlkU25NRVBB?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C64DD8123A097744AF1DAEC323F0E75E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a089b6b6-37c9-4e28-1e52-08db1e396597
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:53:26.9116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x315Uwv3UCuxVCvzUmG6kk7zZL3Glx1RKzBrl7KyxlvkwykmdDJUUMBzxnKn3jxsg3edtv5eSg0sAhiD3BavZA1fpdntHQcX7aHTg+k05X8=
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
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgfCA2ICsrLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMvcHdtL3B3bS1h
dG1lbC5jDQo+IGluZGV4IGNkYmMyMzY0OTAzMi4uMGM1NjdkOTYyM2NkIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwu
Yw0KPiBAQCAtNTExLDE1ICs1MTEsMTMgQEAgc3RhdGljIGludCBhdG1lbF9wd21fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0K
PiANCj4gLXN0YXRpYyBpbnQgYXRtZWxfcHdtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiArc3RhdGljIHZvaWQgYXRtZWxfcHdtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBhdG1lbF9wd21fY2hpcCAqYXRt
ZWxfcHdtID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+IA0KPiAgICAgICAgIHB3bWNo
aXBfcmVtb3ZlKCZhdG1lbF9wd20tPmNoaXApOw0KPiANCj4gICAgICAgICBjbGtfdW5wcmVwYXJl
KGF0bWVsX3B3bS0+Y2xrKTsNCj4gLQ0KPiAtICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4g
IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGF0bWVsX3B3bV9kcml2ZXIgPSB7DQo+IEBA
IC01MjgsNyArNTI2LDcgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXRtZWxfcHdt
X2RyaXZlciA9IHsNCj4gICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNo
X3B0cihhdG1lbF9wd21fZHRfaWRzKSwNCj4gICAgICAgICB9LA0KPiAgICAgICAgIC5wcm9iZSA9
IGF0bWVsX3B3bV9wcm9iZSwNCj4gLSAgICAgICAucmVtb3ZlID0gYXRtZWxfcHdtX3JlbW92ZSwN
Cj4gKyAgICAgICAucmVtb3ZlX25ldyA9IGF0bWVsX3B3bV9yZW1vdmUsDQo+ICB9Ow0KPiAgbW9k
dWxlX3BsYXRmb3JtX2RyaXZlcihhdG1lbF9wd21fZHJpdmVyKTsNCj4gDQo+IC0tDQo+IDIuMzku
MQ0KPiANCg0K
