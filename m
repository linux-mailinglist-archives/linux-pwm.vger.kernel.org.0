Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFB584524
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiG1Rpt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiG1Rpr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 13:45:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A745007E
        for <linux-pwm@vger.kernel.org>; Thu, 28 Jul 2022 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659030345; x=1690566345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nBZJoZB11Q5KE9obYt+eknm9mEYMY/OT5Oi9SBx7F+I=;
  b=P+vioiB+vu8Knkzl6fsJW7N/PYUa3Nzmn8tyiYK4rWrj69VM7b0Ugcb4
   7BF2Fj5SuAy1KuaxOUZeP9542M29InHxkf3jw/yde2nkuAzdyHLNqH43c
   cLP+tNWX4kZEJUR3q4EhluS8WuIEJeRpBnrMlqQx03NIwBmYqGFfQBMX8
   Tca4hrmUg81ZrvXX5+9aHLHLuaHGlCUtapNjQyKWqUEi7LPNvMls37J/P
   Oy0m6WLHFYRFdDOoxU8JLCLuEkRVhm5yAC5GNkdnrnOHcY6dD0c2jzWDh
   WgaKcTZVtFb/qOprYEDxlVd5Q7hpiOrkfMuX/ihR0xNz9T8oi/h/VYRpX
   g==;
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="166831876"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 10:45:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 28 Jul 2022 10:45:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 10:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P488l/S54uk/lQnEwybZUSVKXNTbsXNXvWXWsjeHI5LbE7Vjsp7ZopHIiujwx8jU1Yk9uMuBwcWNTCuUCQudrx8p7ATdQJOFdZrNUggrBoOYWl/rrzrCAqCDH6D05X/AqkNEn2hM8Xi9oToHCSE8W6TXktiAuGHb4Qg7yXouk7VOaNgKAZQHt1hgt/HMKYj4NtpoeBb9/qd9rMtnqL3oK8H+BP+zIvL08z3edjds2+mzJQaiTN6tbfxh8IGIdYX6o9eoDSS3Rn9IzjnWSBqrxKYYZpjIyHiI/VcR7G/uRg/AIbsTyHxXHmkihOOW9I/5zxSnclberxSDKeiiW5nOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBZJoZB11Q5KE9obYt+eknm9mEYMY/OT5Oi9SBx7F+I=;
 b=MbvmI/odacESUm+NuBfqS78/Q9xeMJ5QsFRrWVob2ezPqKkft+XsQma2hCmCa8C7Ky6idzd8KzfOS73OMmNMVSuBLFM/rZHJxcfhgHRNU5NI1pClRbKRQ2LGoWCOBRVbBn7fTwvW3fJxEXElO3prQDVn3/Qz+mGIGeuldpiuME7St6UKYnn7X4rt632MssX0VXwPbdbzFS/bx+XNmtij3szWHVCBbNl97rCry+bYYrSGMbIJeTkzbAnguZBdeoXBL7Z5IIfTNH2TRHZhtQSq7EGzsUSq3g0K7gjZTmVHSYvZmvnMJjeSRTgtOS9RFf9wljTLRK5LuxCwGkMDzqMaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBZJoZB11Q5KE9obYt+eknm9mEYMY/OT5Oi9SBx7F+I=;
 b=AFkp1pDbohB5/Uz7MuMkdmxvSx+11QqRRub5DdslgdZNxcea04G9SNIIrdDgK1jmq3CxPbseA0tQXzlnpEeKSmoa1Nl7tvp88qo138zGzaMM/EPcyNdp4OTny9Grse3AWEagmvTbUj37WMaVLTCp0wuTBd//yq5nqRjjoQM30Y4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 17:45:40 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 17:45:40 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <emil.renner.berthing@canonical.com>
CC:     <u.kleine-koenig@pengutronix.de>, <wanjiabing@vivo.com>,
        <kernel@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <yash.shah@sifive.com>,
        <atishp@atishpatra.org>, <wesley@sifive.com>
Subject: Re: [PATCH 7/7] pwm: sifive: Shut down hardware only after
 pwmchip_remove() completed
Thread-Topic: [PATCH 7/7] pwm: sifive: Shut down hardware only after
 pwmchip_remove() completed
Thread-Index: AQHYnO0pSeG9RSNezEiCiw42RZEnVa2Kq9MAgAlkqYCAAAldAA==
Date:   Thu, 28 Jul 2022 17:45:40 +0000
Message-ID: <7d173447-b52d-4495-56d3-6a59ad3a0bbc@microchip.com>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
 <20220721103129.304697-7-u.kleine-koenig@pengutronix.de>
 <CAJM55Z_+AOmyFs-QgaQdnk4m7SN=JMcszjG+mtANzBcWkGYBkQ@mail.gmail.com>
 <YuLDaawwep6noOJL@orome>
In-Reply-To: <YuLDaawwep6noOJL@orome>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d07f3c5-35cb-438d-e49d-08da70c0fce2
x-ms-traffictypediagnostic: CH0PR11MB5564:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+lKIlFdhe5HjHZpJ7BAre5Ee7MbZPWvL+2PXdniXp5Ah/YmoRFFpWN/+iD7rWvljdENhkbq3HKO+rB3UIbCEMhH03rj1P1YLJuHGRtaohMxs2xru42jvHQyQcPqMy8gM2/AFKvPpveBm2uCZxK3c6aSLf2fIOz8zMX1pFAJuNAB+mwqR55/lKHNTLeapZ768yaXKZVFCzItaTDStX01jIIYlP5M6DjjXmIme9WT7QGqOOD4RP6q11XRINYBZ/Kt0d8j67i/Ahyfbw5Id+ie4VA2pLiw+80AcEm47WyH5wn/0uw1XCxtgdJzXFtDKf0s8oorB2TqyzFtssnEnK7Gz21T72+ZlDfqeL869k9FIvKFY/qR4XJY7GHxKcywTyp/BPCPPiNZRqUnuXBTuwCAP25aASKh/9Pe4TlxkT29zV4C838tHqPZA6pkNGByqtcIuCBZ6kBx5wxUjuUv0QYSAJZFVWOMQ0TW7NWpcFQ+WsWoz5OKp7RfQtt4NGbSYPzT+Rp+wTSwlW5uBffxgj3qdI/Iv1lEfZcoeEIQWAqCTJrhS5nMisHD10Ih/xhfbcb27XNdoBaJ+t1FOcJBK5aFvtFH6QR4ps+CCXdiq8JUy5aisoz6QY3VTkwzDsMuyHs3Nr9aauf2uu/10hd3E9Ux8NUR0bJmZdkRtstkT08HPjtvsnLdBCdLDvZgafUIDijv84DE8pSN9TIRq3pKUPN8/h1qRZZlr9+wWuAt+4SevKzXHQ9PIzrdW+8E0aGsuaTUxHaHSbKiBofScVzVpmQKXy5pO+w0aW6YNNZKxaUAswIhKaObw+VIHNl0HvPfX9pszyf4+rpvwSk0CWzrTVOz7F5xnQkgnSwm4oWu+sgzoZP7+CtYgJZ40PE5wafMeM+1Nxtosi45qPgkr3NOiGigdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(396003)(39860400002)(316002)(26005)(6506007)(2616005)(53546011)(54906003)(31686004)(38100700002)(2906002)(122000001)(66574015)(66446008)(478600001)(4326008)(66476007)(66556008)(7416002)(8936002)(36756003)(64756008)(41300700001)(8676002)(76116006)(66946007)(71200400001)(91956017)(966005)(86362001)(6512007)(31696002)(110136005)(38070700005)(5660300002)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC91dzQvSWR0RXplY2JjcGV0dC9ZWW54eXl0NE9Hb1g4SEpybW1KOS9GN3Rk?=
 =?utf-8?B?ai96alVIeWFMNnVYbUNDSlVBV0dTMkNNL2k5TVNoaVNNMVhlckNHZ2ttNUJ5?=
 =?utf-8?B?OURqRzVYVHhINjFEazV3aVZWQzEvUStyNnlteUdwZE5Gc0VRVFhrWDJtR1lm?=
 =?utf-8?B?WXNEYnBhcGVTbFVvOEpPbXZwZjNpazRLci9YM05DYUI3TzNRT0lvSlh6VEd0?=
 =?utf-8?B?QlhYRzNFTkV4OEFzYkFTMGx0ZFZld1ozODYxOVNsVFdwUXViUndhc1hTVFRk?=
 =?utf-8?B?eE1xbWR5ZDYwb1VFZm0rN1hNTnJpVGluMTR5cmw4RXVVYnlyNW85QXdhNThi?=
 =?utf-8?B?Q3ZrbGpwYmMyVS9WL2g3N3pQRTMwcFJ4VHdrTkJGczlJM3pZS2swUVJLVkhU?=
 =?utf-8?B?cUh4a2RPaTlTTzJRaGlrcmJONUlPdElrNHhiRVhMd05SQjMyRkp5RlBScXZJ?=
 =?utf-8?B?UWlGZjgvWkNHYXJkYkNUL0tkUjlCZmNZVjFERkJkYk84SElicjc5Yk91SlFW?=
 =?utf-8?B?MU44NDI0b0ZLNThuakEwdTNoSjFGRjVHZkxtd2NNZU4vblFPazJHOWtGU01j?=
 =?utf-8?B?V1c0bEJTZkh5dklwYzNGcGlBWHFPdHRld2prRzZKbXhVZDBHWVdWWWVZS0ww?=
 =?utf-8?B?R29jRlJtMUREclNzQlRxTzAxWWZITC9BWWxDK05pdDZUWmwzSk52SUVsaU0v?=
 =?utf-8?B?bHR6RDN4OTdDY0pheENjUjArc21BSGcxSHBVZFVZSzMzeU1rZmtqZG1VY0pZ?=
 =?utf-8?B?T1R4S0JGc3duZFZ6d3Z6T2kyWDJzOFU1VjhPaUVxREl5QmR3RUtLcnJoN3Q5?=
 =?utf-8?B?WStvYW1NbWNuZ0dLVWlwMk1adDRVeGt5SCtxbURidkZSUEpQTUZ2amYxdC9L?=
 =?utf-8?B?d2p5S0pMbXhxV1ViTzUwTDJHZy9kNHROb1I0dTlNa0UvalNuTGw3empibllO?=
 =?utf-8?B?dDE1RmtXMmZFTTIyNW5kMXVvVVptVEZ0dEwza1JqcGFFL3hubW1VT1VQZWNk?=
 =?utf-8?B?bjlyNlBoSHZQVGxlcVIvaVppcVE5SjlIbkw5YlRvb2VwRjIrV2tKRlhrT1ph?=
 =?utf-8?B?bjZGeFFQNklMK3V3aVdNWCt0YktQempQUDAraEtnd3ZyUFcyN1J5UHJaVnBn?=
 =?utf-8?B?M3M5MU9semdOekIwelJDZFNYdmRKV0lOL2FZUHdlL2xWWmZCSVMrVndJRjRj?=
 =?utf-8?B?R1RqNVV2bW5Hd3VMY1Q5cGsxa3BYV2FLdTl0NXNpdDlMbjlJZDNvNUhPdzdl?=
 =?utf-8?B?TkNRNUFuWnQxaXQ3NUhXcSsxUFBGWUNXTXVucVcwdmQ2RzFSeTdMY1VzSEVp?=
 =?utf-8?B?TzdsNC9QQklsdW5CYVpuT0E5UDZia2F4OHNhVmpPT3VPVVc2SnM4b3RlVjhH?=
 =?utf-8?B?Y2pNK1pQVmF6UDhpdU1UMVIxTU9NR3dSSytwRFNNZUpZeG1rTWREN2pGVGZu?=
 =?utf-8?B?VDFWMER6ejl5OGxBRmdBam5oVWtFU01vZlBVTmVKSUo0U3M4MVlMNzdnanNi?=
 =?utf-8?B?NDBkWGY5S0tHbW5yVzFpQmxPeW9LcWF4VDRQcngwS0oya2laVDBwUWJ6TzNn?=
 =?utf-8?B?N2UwNEFXeFV3REpHN3UzaHIxTEl1L0tsa2Eyc3VRMmJHS1JGZnNtRjVOR3Ew?=
 =?utf-8?B?OGJsWDdXWUVFdjhKMFcycjRmUGh5bnJ4YnNCRWdIeHNFNGFwTitOT0RFK1pV?=
 =?utf-8?B?N28yVnlGdW56R2RTZ1RKZWhobnJRTU9kbkplaVVoTjhUdDN4VHRPUityazM1?=
 =?utf-8?B?b1dpU1J6V1pLSHh2bDNuY2FjQldxWDBReHNETnBTWEcyMzdXTDJLWnF4b3dx?=
 =?utf-8?B?MkEzYk4rTGtmS3pwc3BUYlUraHNYMGd2YVU3cjNEVTlLMit1ZDhubW1xMDcw?=
 =?utf-8?B?RUhZZWNnUHBGUUZrdjA2Q1NFbWxySHdWUk04TWRJMjRNeC92RkV1cGEzd2RY?=
 =?utf-8?B?SkxKajUwM3M3djg3Zmo1VFcyNWIvMFoxMS9ISVVxN2MzbENoVFRIMnk2T2h1?=
 =?utf-8?B?Z2d1ajBsU0RzamMxS2RERHplOEFMWVZLN2xXVDJLanBLc3FSejZVbHRVMlNn?=
 =?utf-8?B?TmNlRGNjVTdxM09mbEZtLzJWdnhiL29YZlVwVTExN0E3UVdtaTVPTDFEK2VU?=
 =?utf-8?B?aG5SU1MxcElib1ByaS9Jekc2VG95UEVwbFB2b1hPdUlTMTE3VWtMb29YZHhR?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <048991DE12267548921710621D8261FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d07f3c5-35cb-438d-e49d-08da70c0fce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 17:45:40.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jj3MNb6jveJjoWIyADDDzYiZp3UYnPt+FrbCMEMb042ENdnOM3t0Ck9/lHQgsPoBoGHchygdRkxFV5nnIk0G9Ft3QaE+fPgNOKc4LcGE9Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMjgvMDcvMjAyMiAxODoxMiwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBKdWwgMjIsIDIwMjIgYXQgMDc6
NDU6MzJQTSArMDIwMCwgRW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+PiBPbiBUaHUsIDIx
IEp1bCAyMDIyIGF0IDEyOjMyLCBVd2UgS2xlaW5lLUvDtm5pZw0KPj4gPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQo+Pj4gVGhlIFBXTXMgYXJlIGV4cGVjdGVkIHRvIGJl
IGZ1bmN0aW9uYWwgdW50aWwgcHdtY2hpcF9yZW1vdmUoKSBpcyBjYWxsZWQuDQo+Pj4gU28gZGlz
YWJsZSB0aGUgY2xrcyBvbmx5IGFmdGVyd2FyZHMuDQo+Pj4NCj4+PiBGaXhlczogOWUzN2E1M2Vi
MDUxICgicHdtOiBzaWZpdmU6IEFkZCBhIGRyaXZlciBmb3IgU2lGaXZlIFNvQyBQV00iKQ0KPj4+
IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGU+DQo+Pg0KPj4gSGkgVXdlLA0KPj4NCj4+IFlvdSBkaWRuJ3Qgc2VuZCBhIGNvdmVy
IGxldHRlciBzbyB1bnN1cmUgd2hpY2ggbWFpbCB0byByZXNwb25kIHRvLCBidXQNCj4+IEkgdGVz
dGVkIHRoaXMgc2VyaWVzIHdpdGgNCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1yaXNjdi8yMDIyMDcwNTIxMDE0My4zMTUxNTEtMS1lbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5v
bmljYWwuY29tLw0KPj4NCj4+IC4uYW5kIGV2ZXJ5dGhpbmcga2VlcHMgd29ya2luZywgc28NCj4+
DQo+PiBUZXN0ZWQtYnk6IEVtaWwgUmVubmVyIEJlcmhpbmcgPGVtaWwucmVubmVyLmJlcnRoaW5n
QGNhbm9uaWNhbC5jb20+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NClByZXR0eSBt
aW5vciBJIGd1ZXNzLCBidXQgdGhhdCBzaG91bGQgYmUgIkJlcnRoaW5nIg0KDQo+IA0KPiBUaGlz
IGlzIGZpbmUsIEkndmUgYXBwbGllZCB0aGUgdGFnIHRvIHRoZSB3aG9sZSBzZXJpZXMgc2luY2Ug
eW91IHNhaWQNCj4gdGhhdCB5b3UgaGFkIHRlc3RlZCB0aGUgd2hvbGUgc2VyaWVzLiBJJ20gbm90
IHN1cmUsIGJ1dCBJIGRvbid0IHRoaW5rDQo+IHBhdGNod29yayBhdXRvbWF0aWNhbGx5IGFkZHMg
dGFncyB0byBhbGwgcGF0Y2hlcyBpZiB0aGV5IGFyZSBnaXZlbiB0bw0KPiB0aGUgY292ZXIgbGV0
dGVyLCBzbyBpbiB0aG9zZSBjYXNlcyBhIGJpdCBvZiBtYW51YWwgaW50ZXJ2ZW50aW9uIGNhbg0K
PiBiZSBuZWNlc3NhcnkuIFBlcmhhcHMgYjQgY2FuIGRvIHRoaXMgYXV0b21hdGljYWxseS4gSSBz
aG91bGQgcHJvYmFibHkNCj4gdGVzdCB0aGF0IGF0IHNvbWUgcG9pbnQuDQoNClRoZSAtdCBmbGFn
IGZvciBiNCBhbSB3aWxsIGRvIGl0IGF1dG9tYXRpY2FsbHkgZm9yIHRhZ3MgYXBwbGllZCB0byB0
aGUNCmNvdmUuIEluIGZhY3QgaXQgcHJvbXB0cyB5b3UgaWYgeW91IGRvbid0IHBhc3MgLXQgYW5k
IHRoZSBjb3ZlciBoYXMNCnRhZ3MuDQoNClRoYW5rcywNCkNvbm9yLg0K
