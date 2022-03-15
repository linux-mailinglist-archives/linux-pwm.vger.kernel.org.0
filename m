Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3C4D97B4
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Mar 2022 10:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbiCOJe2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Mar 2022 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbiCOJeZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Mar 2022 05:34:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913F2613C;
        Tue, 15 Mar 2022 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647336791; x=1678872791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sUgwgqD5kDLHCb/U7eT16U8HqA7ZtiQkC3Jg/5/mB9c=;
  b=N/vrgi30hImipPHLAaYv30mzzgZ5uRtzR+OB8SZ9Z3wBweGB2iX0M1hR
   wNX7UynWMzqxIDhDvcqqUkDQgvS3S6Gb0nupkDyTom7DKy66PfhLHAtoz
   t9GvKimSQ5u0UpcF5IMBSvaInn+ltAnUeaCrj4Vfm/7oFV0qb/rsbr7Qf
   Z0/cDlIIAwWBVJFX9EJYu4XIYp6UqKq0PpYztJeCPBay6qKQZooq+kG5f
   JkpJo9rGgDyRZXxGzCnLp78GRA9c5+P9HpqzahNdyept6TF3VpTxzbGB5
   guKC0M+TDbDu4e2jJ/RcclNH3xQblCB+qGXXhBDln7KxbyYzgbB0CegOG
   A==;
X-IronPort-AV: E=Sophos;i="5.90,182,1643698800"; 
   d="scan'208";a="88958853"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Mar 2022 02:33:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Mar 2022 02:33:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 15 Mar 2022 02:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW4Wrn+JsMxbxyLS4nmDWg8RFGOzMUIbOVQcSo/MmDHrfbeyMk6nt+HyComIXvJ8jQTu/Qqhl8hNJhIdzEtf2KkBW2h6c6dOt9zE1IsvVw/FC3yGzd/I/bU0iW5OAc/xazE2PEreqkZ0kGZwwZ+yvFJMSzISU4OQOhThXCRp19aPh1vTnfLSyKH/+2dhNLn9KROiIe4VJpyRoP6qzHYoG/GV9rMj/XMD1ZtPHqkHTJ1X4SKs5+yl6mpW9VAE7zqbZq7+F3DmbsFabTxE7Joyh5AFqCfDP7mHNWLuapfvx/rTmeWfoUg36Cqzt/Wwr44V/gj/a6UY7WYtSx9ZaCCdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUgwgqD5kDLHCb/U7eT16U8HqA7ZtiQkC3Jg/5/mB9c=;
 b=SIQkslQgWsj2coW8N+PaRu5huUAnShoyvLl/0YwzwsZqXFwNmSC1+e5Q4MRWgDL4VNeXv7oiGXKUbpQ4q/NQhqkhQmEBWFaxLGaGtgvhAbh3OxZyJCbQjBSfzYoo8KhEjKbXAt6HHObKc0AaUp9kMfuDh35fGtT4VAbOIkyWdXGoHOxbht0SK6cwdFgjHX43heK9Gh0zCycjX8F6jlE4e+HCwldY2s1q/GfaQLQrltKD7q4zLFsrU0yfxvo8YZKPDVMWyuQC3/SfyxYa8nxTObya4tGMWz6t/6qpbOlOe1VsTLdsnrmNDNorIZSB6Cs9NgJPlGrLV+7NZKjpjrJHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUgwgqD5kDLHCb/U7eT16U8HqA7ZtiQkC3Jg/5/mB9c=;
 b=gE03EKc+RsDxdHbKiP/loudZVIP6iDDld66nSb+4WHIwYoCvr/etjAY7sakyZEKlrd4+Ac81X1cLaezkZ1YERXD4m6pXzAUHS7pAUremnSiDYDX79MGia70veB/yNomA2bRRMGw3rTsLyenFsEovT0uENsDcwHQjwgFm6nfv8Tg=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 09:33:04 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 09:33:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux@armlinux.org.uk>,
        <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <aardelean@deviqon.com>
Subject: Re: [PATCH v8 12/16] pwm: atmel: Simplify using
 devm_clk_get_prepared()
Thread-Topic: [PATCH v8 12/16] pwm: atmel: Simplify using
 devm_clk_get_prepared()
Thread-Index: AQHYOE+rHJZZXqld7kuL46Mx59Vcsg==
Date:   Tue, 15 Mar 2022 09:33:04 +0000
Message-ID: <22caa484-06c0-f38d-e0de-f2c5f78fb8c2@microchip.com>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
 <20220314141643.22184-13-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220314141643.22184-13-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8d61af6-9f35-4a2b-79b8-08da0666ce76
x-ms-traffictypediagnostic: BL1PR11MB5383:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5383CDBE029648952009450B87109@BL1PR11MB5383.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkWdh9m/pmNHyTzaF510C80x9jE/IrVDxS6ZkgtXW6WkTDTltudP79yCOEU/3cb3ifXOJ3q1Rg1T3eE6VAGfbaVfFg6+H9FnDmGFJHCH2MLjnPcUy8ZQY4YhK1aSBY5K8gmSidkWBWWwaDu+6MqyI4yxxb42OH3mnBATOUZGC1hQq/mMp+Dy6vtxQOxRfFRlw5lufzla7GcStGF4yd776FoatdVT7cgQj1xAh7Tt41S9AUW7q43hnxEW2zxzwKrKkfOgs5feKT8sCu22f+SXjjRZkU6OpiK5NN/ZfoSgm2GxtW5SrmVpjs3DOaIsT+wNFYgWMymXXHJ5xdSq+NU3doWZFasoAnW6MTFRQ92soOfMcRAmHcyx26DbdIc4MODrrrLM1xPq8X/MTUzFlbfyj/I0kVeAeQq8STUmaYVPLsUPYiD4TCr0nXPL2IwEN6tjQ73uXw8B/CTjIOgLuzcmVM7MisDS2McCI9zC7ZVU43SqojN8PHE7Sq51XOhszWfgy2W6Q6XWsOmKbbZMlcm1mvhzAT4hIflvaWPhcS9CqFEQigozp9pSWW4Ho0vgdU/cTexdpFjZ6TyBTKf6CU9m6OSMiukNHMF/+Yzct37MzuJoscY48U9oun9ipJWtx2Khh/Sim/l3bhwHR2Ajhydb+h7MHev5xb34EV5/oR8Vi/YHda76nnpGaR43Zz9Dan+qA7ulI/zOm6a0z0ZubDsBubkeXxoIydU50h9VfGEiw+JK6kXfjBGWfUWJD5PMP85+yjoVS0QL+JLaxf6YBVTP1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(6512007)(38070700005)(2616005)(7416002)(8936002)(31696002)(508600001)(31686004)(122000001)(6486002)(64756008)(186003)(316002)(66476007)(66446008)(2906002)(26005)(54906003)(36756003)(110136005)(91956017)(83380400001)(71200400001)(76116006)(66946007)(66556008)(8676002)(53546011)(4326008)(6506007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzhjdUhCOXpRazRHd3l2VnNBVkFLd1ZxbE5mRkhLRXplTUVaZksrOXg5dm9t?=
 =?utf-8?B?VUNvdDJmTlNjOENRbUtlV0N4b0hxcDA5cklMMkNlL0RjbXVzdzltb29wcEI3?=
 =?utf-8?B?NzViME9icmlhb0NHb0pwdjFBUUVrZWd2UTdVbnpWc2VGZEZBQ2pvbmk5eUpC?=
 =?utf-8?B?akVHVVRqZ0RzdE9MRFlwbXljcGE0TEZ4Z2FNSFZrSFRuSGp2Wi9iQmhDZmxC?=
 =?utf-8?B?UWRmOHhxaVRndW9aSnVjNTF5NGV4SnFmdHVyM2pOUERSemlhcTM3Tk0wckQ2?=
 =?utf-8?B?QlBNSjNsUnF2c1kzSlQ5SjQyV3BGTmZQcTVqOCtCRkt3RTY0MVAvQkJBMVQx?=
 =?utf-8?B?K0xIcm9Ga2JMK1J5Vk10UEQvZUNKVzBZSEtyQXIzT0F3bTJsRGxxYUlKR2lN?=
 =?utf-8?B?SjhmNm5scUhGNzJURzJYMW1tTkVWZERIUVJ6YmxlYTZJQXA2VURlMzh0MWZ6?=
 =?utf-8?B?MkZKdHZYVUEwWFpwSlUxem9lNFFkNlhlbzlOSjFSRWI4azRtZ1I3U21jazB3?=
 =?utf-8?B?Ni9xdGlwL0VGVURlRmh5NHdPZ01qZkxwSklaSlZsUXJCd2F1bUVPV2ZhK0Js?=
 =?utf-8?B?VUxHVEFndUd4UlM4TWxFa2NqSXlNUzIxVUNLZHFqd3VldzF4ck1FOUttVUw2?=
 =?utf-8?B?eU8rZGhaNGswcDU5YW1oT0RXSXRObTROZmhjcythK3ZHdkVobWJFN09RdnVU?=
 =?utf-8?B?U3YyTE11aTBod09DMENyY0dqZFJTeURoSmhsVHpvbjNHYng4VXBYQ2toRUpu?=
 =?utf-8?B?RjNJaXhzTjBDbGlRZXNyRUdpclRmQXh1UUMwQzZWYTFrdVlYQ085Tmo4UExT?=
 =?utf-8?B?VFBXVk9GQnZDdzI2RFhMN2ttYnpyT1BZS0lDS0xhajRCdE15cHAvcTJDUXJn?=
 =?utf-8?B?NHNoT0ZEL2ExY25lWkowY2ZNTXdubHh4L2lkRUZBc2MvdG5LK1hnTTNRcHhT?=
 =?utf-8?B?eUlnL1d5NkVDSW9rN2FYbiswanB2T3BOQ0FMcWNWNG52QnA5a0pEa29KMTlo?=
 =?utf-8?B?VlpOYmErVjM5SmFDN3k0SEpOeXNlc2R4V0lxaEpaalg1eWZBeGE4bkc1WnhS?=
 =?utf-8?B?czBHS3VQYVZkR29yWE9PVytNaHpKTldmU2RqU2hDWlE2L2tHV3Y0SlJncElm?=
 =?utf-8?B?eGw4azNYSTA4cWgvN0FPazI0SEFpN3hrV0FjdkJ6QW9CMFVIeUpXbll0WVM0?=
 =?utf-8?B?ZXErMm9PcTRZcm5XMXV0V1hacjkwUlJ3SnducStEZzVLT0U3V1VSTVJ4MGZj?=
 =?utf-8?B?cGp3cWpabTkwSTcxTkxHY29BZEVibVQyaitEN1dOc1VLS1VGWVhLbTh5aGNG?=
 =?utf-8?B?VE1pMVVrbkViQ0JFTU9UaUJEcURzQ3JWR2dVTDBZa2dqaXVUTTFQeFRvdXFV?=
 =?utf-8?B?bGFtUWk2SS9wYVgvTGpYSUU4RHVwNmEvUGdjTVVFcnBGZWcreDkwNlV1ZUJK?=
 =?utf-8?B?TTRnNk9HS2RyQmdlWmQvZDcrY2wzVTNJVlEzUlhJdno4cTAyR3BxeklVTGdT?=
 =?utf-8?B?VmdEK2FwSmQ1SkdtaDFkTFhYejB5REdpYjJFMEZWZGJ3L1oxaGYyL3hpOEtr?=
 =?utf-8?B?RmkzYllxQ1JVTHNraHhvelNCVXlONEVHVU1JMVJ5Z0U4dVpZdEdJMUJCaUsr?=
 =?utf-8?B?dGhQUHNoVWd4T1ZIM2Q5UXc3SDFJbWY2YlN3U2IzdFNSMU1weExtemRJTGFR?=
 =?utf-8?B?UlM5NXoxVjVOeTUxK1BFSit4ZlZiOEVQc0lIWVBRc21Dc25tRjR3dkFlcmVB?=
 =?utf-8?B?aCtSK0FkVVJ4UEZCYm5lOSsyRTlaUmwrTWhXTnhpWFQrYW5FTXM4a09hbWNi?=
 =?utf-8?B?SXBIZGs2Zzdsc2liUFRsb2ZDQTBMdUpZOG5lNjVVb1hHTDMyZkdtZU0wMUdn?=
 =?utf-8?B?MFlzbThpM3RRMFZ5bllzOVB0amw2YnVHdW9tTUxKbDZ3T2Q0YTRvbXlUbEtM?=
 =?utf-8?B?RmtZem84c3RvRktla1VINGpmSVhPcG1QclFGczYvT0JZYnQyV3hXZEUyRys1?=
 =?utf-8?B?T1RDcVNUem1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A3C952257E72844B8C657B7B11D4344@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d61af6-9f35-4a2b-79b8-08da0666ce76
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 09:33:04.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ke/zLwF6rD6/4Y3POA5WGJ5ku9abjLw80SXZOPu8HA5piu9U473Sy5yYGK8a8tCV55G+jeTw8krwbMJJmYYyqi7axVjvqFeHdy84zgxLW4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMTQuMDMuMjAyMiAxNjoxNiwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gV2l0aCBkZXZtX2Nsa19nZXRfcHJlcGFy
ZWQoKSBjYXJpbmcgdG8gdW5wcmVwYXJlIHRoZSBjbG9jayB0aGUgZXJyb3INCj4gcGF0aCBhbmQg
cmVtb3ZlIGNhbGxiYWNrIGNhbiBiZSBzaW1wbGlmaWVkIGFjY29yZGluZ2x5Lg0KPiANCj4gQWNr
ZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWFyZGVsZWFuQGRldmlxb24uY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJv
bml4LmRlPg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgfCAxNiArKy0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2Ry
aXZlcnMvcHdtL3B3bS1hdG1lbC5jDQo+IGluZGV4IDk4YjM0ZWE5ZjM4ZS4uMzA5YzMxZTQwY2U0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJz
L3B3bS9wd20tYXRtZWwuYw0KPiBAQCAtNDgwLDE2ICs0ODAsMTAgQEAgc3RhdGljIGludCBhdG1l
bF9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBpZiAo
SVNfRVJSKGF0bWVsX3B3bS0+YmFzZSkpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VS
UihhdG1lbF9wd20tPmJhc2UpOw0KPiANCj4gLSAgICAgICBhdG1lbF9wd20tPmNsayA9IGRldm1f
Y2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gKyAgICAgICBhdG1lbF9wd20tPmNsayA9IGRl
dm1fY2xrX2dldF9wcmVwYXJlZCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gICAgICAgICBpZiAoSVNf
RVJSKGF0bWVsX3B3bS0+Y2xrKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGF0
bWVsX3B3bS0+Y2xrKTsNCj4gDQo+IC0gICAgICAgcmV0ID0gY2xrX3ByZXBhcmUoYXRtZWxfcHdt
LT5jbGspOw0KPiAtICAgICAgIGlmIChyZXQpIHsNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIo
JnBkZXYtPmRldiwgImZhaWxlZCB0byBwcmVwYXJlIFBXTSBjbG9ja1xuIik7DQo+IC0gICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiAtICAgICAgIH0NCj4gLQ0KPiAgICAgICAgIGF0bWVsX3B3
bS0+Y2hpcC5kZXYgPSAmcGRldi0+ZGV2Ow0KPiAgICAgICAgIGF0bWVsX3B3bS0+Y2hpcC5vcHMg
PSAmYXRtZWxfcHdtX29wczsNCj4gICAgICAgICBhdG1lbF9wd20tPmNoaXAubnB3bSA9IDQ7DQo+
IEBAIC00OTcsMTYgKzQ5MSwxMiBAQCBzdGF0aWMgaW50IGF0bWVsX3B3bV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIHJldCA9IHB3bWNoaXBfYWRkKCZhdG1l
bF9wd20tPmNoaXApOw0KPiAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAg
ICBkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gYWRkIFBXTSBjaGlwICVkXG4iLCByZXQp
Ow0KPiAtICAgICAgICAgICAgICAgZ290byB1bnByZXBhcmVfY2xrOw0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIHBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIGF0bWVsX3B3bSk7DQo+IA0KPiAgICAgICAgIHJldHVybiByZXQ7DQo+IC0N
Cj4gLXVucHJlcGFyZV9jbGs6DQo+IC0gICAgICAgY2xrX3VucHJlcGFyZShhdG1lbF9wd20tPmNs
ayk7DQo+IC0gICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IGF0bWVs
X3B3bV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gQEAgLTUxNSw4ICs1
MDUsNiBAQCBzdGF0aWMgaW50IGF0bWVsX3B3bV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gDQo+ICAgICAgICAgcHdtY2hpcF9yZW1vdmUoJmF0bWVsX3B3bS0+Y2hpcCk7
DQo+IA0KPiAtICAgICAgIGNsa191bnByZXBhcmUoYXRtZWxfcHdtLT5jbGspOw0KPiAtDQo+ICAg
ICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjM1LjENCj4gDQoNCg==
