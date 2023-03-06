Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010F6ABECB
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCFLxn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 06:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCFLxd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 06:53:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259A29403
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 03:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678103604; x=1709639604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3lrCgGYw+3A+IZO9HLT+nDFBqLXtaiEKQXDYXfmjJ8I=;
  b=LuIEJndI9PpDLFieVsVpXZMAs5hgFFvXOq9D3c92l05+Wvu5ASggqAmr
   nMM6YH+1dDXkCtDmB/7J9j/sp1jVGMVgBZBGIgZpStwQjWkr5k8LSzf3O
   dL5zS3VJPdenwPFglCDLe2WxRkiTqrUzrdH14lteAq5eMRfcVRpdvKJbi
   3hYl1K5B95hHH/+gfzcRaofFHYXfsiFd5CTKpbnvSZZyYzrYMN/oPWpW8
   aYLjADi/x+N49DP+PQiDcwhSvJ16c1xKgxCUKXl/bTnTEbRdFRcBn8vUN
   iMHxrsgTET5XKK/isq1gTFBG6BHfEg7QmK30lcbOR8sljLfz2/Yt/9qNB
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="140461981"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 04:53:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 04:53:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 04:53:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0bfXIMgBAH7uuy4rHLHo3VZ+C1wb3w4TyyVPdl+eTfeVfErbrK29Sox2RbA8OYu6TIUKVB7+k2cLVp7LvYWQxcUgYC0EoF24SMdebzLxcNouf3uWam9z8HOKoJNEC5JGDfVmmK7Icu2S53VVl1mOKecOpCph6nQne3K3UntM7I0CgYmW0ywS9jAuz8btiLMKF/VZYHJ4Mgo16ZPcIDC63gyuwBipp+y5jRIlubKyl7U7ujwJ12VAt5PZ67/ekuNOak0fGlB1Y9uILZo8a0/ucX4Mry4SNfbZBHarXcjBV2fXN7QdcyfGJS+vKePTONQukyOy291zTTOp8sBRr5hOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lrCgGYw+3A+IZO9HLT+nDFBqLXtaiEKQXDYXfmjJ8I=;
 b=jVDK/4aXosTJPepDg7ArRtA6oDKyY7WIrfFB1Eh85fzdjikVBbe2BlanOEsMZnBoGjfAMEIUpfA9naZWL3jUM0mO3LLjlJvoKVQqxjh/WR/voI8jBxL+T0J8pd0ZXkAF0hOFxK4IbF7zNrlIe85yUktAXlXpqwW2iXcHssYM0HuYb5aaXJBR/XrIyxdGf7hRWW9aHvZZYKrz55CfOAcuCQwoCKHWHpmh7FORcOLXhkNy+Q50ff+/L+m9NWtvbVq7zc9qWV/UBbkdeY7rnCohWV7f6h39AzeaZk2u6kr+s8Gz5kp78i8mi2s2bKoXgUUJW3FPe3vxvCQvXo7IrqcQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lrCgGYw+3A+IZO9HLT+nDFBqLXtaiEKQXDYXfmjJ8I=;
 b=KCOSp1euaCTG2gRT6sfW4CEhOywf7WKRQnc5I9vew/GEeD9PCeiqH8VblPpFGUeoL6fWtNDO2ruuEt7ar/1oZnRibjGIFO5sDSQzJkzAp19+ahHOACH+Ul9WPK143jmwSnOsg3ZJoDeR7G/bh8zAkEzmqLa5jcex1qRfgMJ3Gl8=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:53:17 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 11:53:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <kernel@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/30] pwm: atmel-tcb: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH 02/30] pwm: atmel-tcb: Convert to platform remove
 callback returning void
Thread-Index: AQHZUCI9WF2Ywei5akmQzzVPfBmSlw==
Date:   Mon, 6 Mar 2023 11:53:17 +0000
Message-ID: <3645650d-b9b5-ccad-0051-6a88035146ad@microchip.com>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
 <20230303185445.2112695-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303185445.2112695-3-u.kleine-koenig@pengutronix.de>
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
x-ms-office365-filtering-correlation-id: b5d9d41b-7f0c-4b92-f27c-08db1e395fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swvhmFdL5zS0Wo6WDWWv11qrCKO0v2zbpJEi+1ePhXa58qNGkVDg4L/trNiDCvUFRVCMaI4rFGpLec3hr8Am9BNL1t9KPFAeJun1dgmKGGuISynZpN9HrtSku7PYn+NvY8ZxEZagFRyWa0QJmMFSD1HHmg6gKPbWLZgUBA00r7Lt3Qv17QQLeXoIMJORxU18ci0/Xo2Ijzg8SXbVkAGlpAf5RfL9s4iB8P2H0idq7hjjqtw4rpPh5vAhxWa5pfZRCdHFgOM4oHt5fl1bYiOZ9twTXMn6CSkyGKUjqp5hA4+eXKwXTKfFwmPxm9focn2QEonT8DaduZg7jr7mr8x/0AggfLc7DhJV0Ooiu5+X3arH/fjAEtqARvLCv0pGAfCDp2F2T2de6YrEEfsgrBL8yyCmZcmuckN0UvoZKqviKqZxE/ux7DhLFV0ODihjwjA4AhYx2sfv7758v/Zu+a2pRELiN64ct/xUJLBP5ihgTGymvDGU/WnQxNU16ba3DYgL9bGDnwSYMv6hft/VBDU2UoI3l7I46GYyzf0Ymo09SXuotJpEMckb4IUYXZqjO8XkyUJ/gm8jZ8mVpEzxa1MumX84//4Lv8IwT+AQjJBJxxBimfP2DStV9gcrUzFbwGJn7k6iJSLCA7jAoEErAiUPnotCrStRkUkTZP5KnARA1pVx0KXOITOL7tVW4QLkNh2RhrnXw0ag/U25zbiec/vFiz60vBTvBk9J3w2p8PiwXjO3MLwUVX3OBRWsVz+HBPoOBhNoViXK7WAdoMkwO8BFBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199018)(6506007)(6512007)(53546011)(6486002)(36756003)(38070700005)(83380400001)(31696002)(86362001)(122000001)(38100700002)(186003)(26005)(2616005)(41300700001)(91956017)(66476007)(66946007)(66556008)(76116006)(66446008)(4326008)(8676002)(64756008)(2906002)(8936002)(31686004)(5660300002)(71200400001)(316002)(54906003)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0Q0bmpWNWV4WkgyNEQ1UFFDTktUMGlCZU1sNmlFb094S0lNYXhkSkJmbjZO?=
 =?utf-8?B?NmYwMnIreDNsOGNMVjRoUlkydlNYZ3hob0dmcDU1dVo0MUQ5bDI5c04xeXNR?=
 =?utf-8?B?c3B1SzFoYUVHWDJsWUdPc3U2V21CVVByWDIzZ29XakxYSTJkeVVOcDN2Tnk0?=
 =?utf-8?B?MXZ5anpxa1JZVVp4c21KcExCMm91RVg2aVA2OFlBdWVSU2lDZ0k1eUJkeVZr?=
 =?utf-8?B?ZGpXUlYyV2h3enhwY1B2RnpGODFkU0x0K1l6b1R5dElGd0MwcmxYSmVvL1VJ?=
 =?utf-8?B?SXBxZ3ZHQlJEZ05mbnhkVVF6RUJDR2h1UnpjOUVCWitSOGc3dlVHZnVKRHhW?=
 =?utf-8?B?VmtROTVQbjM0NVZZUHYybkJ0NGpkMjE4dDdMYTluTTlIaHV1NEtGVW5DQlpX?=
 =?utf-8?B?MXpsa3NOUmdBUFRFNHFCOGNQR3poTEpOWkVuL3lpTUs3VmlJR2RXK283UjI1?=
 =?utf-8?B?ZkNjZFdSU2FncURjaHB6MGs2NDZhY29YQm1KT1BNS2VPT2xkVVpLZDBpMUtF?=
 =?utf-8?B?YXhZakw5QnFENU9ybVg1N3QyUDJ5cXNreENGSmlrRHY3bTJQVWN3cEdUZklv?=
 =?utf-8?B?L3ZvLzZiV0FTV1ppS0h6eXU3SHlrS1B0aTBWMUN1YTZ4R214YS9lQ0txR3F3?=
 =?utf-8?B?OHAyRVRmYk56V0dOVnlNdGs3bDJ3RjJmeU9Sb2RDL3ViZTZ1bVBWRS9sdEhV?=
 =?utf-8?B?eUNkb09LcXBJQmI4OVMxWGYxUWN5bnpXNFhoZFQzenNtaWswM3ErV0ZZV05K?=
 =?utf-8?B?RGFMemZYdzU3bGJCNjMwOUtlQlpMMm92dlMxbDlwT21qbWxzeVgvREhrZERl?=
 =?utf-8?B?ZHRKQ3JXbHNFaFF4WmVrY0Y2Q1FZeElJNURWNUNUdUsxNzZORHhMbTlVQ211?=
 =?utf-8?B?RXA3SHBKK2dDdklGSFZORUJ2a3JtdnpGNXV6YTBrVzd2Q3dDMTQ0N3BHME15?=
 =?utf-8?B?dUJPRWUyYVM4TS9jVXkzMFJaZmx5ZkV4YTJLLzBzdFRucStTN2NKUFBTcVZv?=
 =?utf-8?B?QVd5eU9SKzJkcDhvUm1mMzNGTjVDd0dUT1NRTEwxSW1lUXdPR0tuQXN3S3lK?=
 =?utf-8?B?UTJjenV6NXdXUG55TTBnc0d5cDVseWg0Y2pjQnVFSzRPV3A1a0IvSWlsTVA1?=
 =?utf-8?B?SnkyMW9pUzY0L0xJRXAvWXZIbFBOWFZLdy96aDNqSEovbFh0YUpWOW1Gb01i?=
 =?utf-8?B?OFF0Wldnc2lXazFkY2l2NG5oYTl5alkzT3RKbjZ1VGc1N0VvSmYvY01aMC8v?=
 =?utf-8?B?RzFNeEY2dmVqSGJteld0YU5xdFNRZEthdk9sZ0ZrRVNubVNwUGlxbHhZZ2FK?=
 =?utf-8?B?WnB6ZHhUUU1pV2JPYllYSnNvMXREOEoyQldtazArRkNScFh0Ry9WTzdRZ1NY?=
 =?utf-8?B?ak9XTDB5SE1aVHBhMFdCcmQ0ckpLV21YeGNjSDdYKzN1YzRWRTVPYU5pSVhR?=
 =?utf-8?B?Rkh2NXczVnhrWGxuc2VadXlZcGtybkNIU0x4Z29PdUVhdVZUdk5mTHlkVkZn?=
 =?utf-8?B?VnBjSVpSQ044WFNuQ3Rha2MvS1JmUzN0bEpRa2dHelhoZTVnRVN1R1NOU1NF?=
 =?utf-8?B?UDBtNWtMOUtadXBzd3lZS1A5ME5KWkIxNjNpL3JLQ2xzQWJOb2FBTW5ESEdv?=
 =?utf-8?B?dk9veFZaTzA4S2hzRTk4UlNHNTZxQVE2MWNPeEVOUTJzVURvNVowY2ZMKzJk?=
 =?utf-8?B?aC9EREdWdDJCYzdWMW80WUtBa2JmbUt2d3hKaDAvRm9ZelY1anVQeU80Q0ZC?=
 =?utf-8?B?a3J5b0RwRTBTbk9mdHQ0TDNJWkUrYm5XRVJ6eDJtbWNyWXRiNXNXcGFvWDdQ?=
 =?utf-8?B?VWV0SGRXc1g5VU50d3lxU1UzNDlFNVBhelRDTVYzV09ycDFiSWxGcGhMdWZ6?=
 =?utf-8?B?bEFTN1pMQmJ1YmNEKzRKeHErNHlSUjhhbU1aYm9sRHRWSmZsVjc0bFBrVU9Q?=
 =?utf-8?B?YnV3L2tuM2xIbytpWmZXSFNkcUk4SnViNTcxUWRTWXNRcFAvNThUWGxCQXY1?=
 =?utf-8?B?Tk9iY0dRME5Cak10Y3ZZbDQxd1Nwb2xSYlRmVXcyL3ZPMEhJNWZWZ1JHSk1M?=
 =?utf-8?B?MWNab0pUZlppb0dabE5zcXlNZ0F6NlFiS3NpS1RlZGVkOFU1djM0TGF3M09l?=
 =?utf-8?B?Y0RWcW5NTjc4dis0eGVhSDRGN3RpamVQRVh6bEZqUEdTeVk1cmpOSmg5YnFn?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <770ACF3173B589459238D1B9DEDD91CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d9d41b-7f0c-4b92-f27c-08db1e395fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 11:53:17.1153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sS2ZTYagmbnPRT8R6E+DEdpwoK6Bp5NreKB+R2WpYhIX2uNWKbdxZ0YQC84/NOTylLYgGxSwoUAVCWjSzA9S79mJl+Vo2VCw2QN2GpqGOMc=
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
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wd20vcHdtLWF0bWVsLXRjYi5jIHwgNiArKy0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLXRjYi5jIGIvZHJpdmVycy9w
d20vcHdtLWF0bWVsLXRjYi5jDQo+IGluZGV4IDI4MzdiNGNlODA1My4uNGExMTZkYzQ0ZjZlIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwtdGNiLmMNCj4gKysrIGIvZHJpdmVy
cy9wd20vcHdtLWF0bWVsLXRjYi5jDQo+IEBAIC01MDAsNyArNTAwLDcgQEAgc3RhdGljIGludCBh
dG1lbF90Y2JfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAg
ICAgcmV0dXJuIGVycjsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IGF0bWVsX3RjYl9wd21fcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICtzdGF0aWMgdm9pZCBhdG1lbF90
Y2JfcHdtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgICAg
ICAgIHN0cnVjdCBhdG1lbF90Y2JfcHdtX2NoaXAgKnRjYnB3bSA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOw0KPiANCj4gQEAgLTUwOSw4ICs1MDksNiBAQCBzdGF0aWMgaW50IGF0bWVsX3Rj
Yl9wd21fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKHRjYnB3bS0+c2xvd19jbGspOw0KPiAgICAgICAgIGNsa19wdXQo
dGNicHdtLT5zbG93X2Nsayk7DQo+ICAgICAgICAgY2xrX3B1dCh0Y2Jwd20tPmNsayk7DQo+IC0N
Cj4gLSAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBhdG1lbF90Y2JfcHdtX2R0X2lkc1tdID0gew0KPiBAQCAtNTY0LDcgKzU2Miw3
IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGF0bWVsX3RjYl9wd21fZHJpdmVyID0g
ew0KPiAgICAgICAgICAgICAgICAgLnBtID0gJmF0bWVsX3RjYl9wd21fcG1fb3BzLA0KPiAgICAg
ICAgIH0sDQo+ICAgICAgICAgLnByb2JlID0gYXRtZWxfdGNiX3B3bV9wcm9iZSwNCj4gLSAgICAg
ICAucmVtb3ZlID0gYXRtZWxfdGNiX3B3bV9yZW1vdmUsDQo+ICsgICAgICAgLnJlbW92ZV9uZXcg
PSBhdG1lbF90Y2JfcHdtX3JlbW92ZSwNCj4gIH07DQo+ICBtb2R1bGVfcGxhdGZvcm1fZHJpdmVy
KGF0bWVsX3RjYl9wd21fZHJpdmVyKTsNCj4gDQo+IC0tDQo+IDIuMzkuMQ0KPiANCg0K
