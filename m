Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7235970317C
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbjEOPYd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEOPYc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 11:24:32 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2123.outbound.protection.outlook.com [40.107.15.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8785FC;
        Mon, 15 May 2023 08:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWDJktLdGlS8Ec3lYjNEJC9INkzAslP9+YwjuFqmGXYS1WPPDvJDVEZ9Sa0wZo5nFR4/bQI6LKB1qBNqQq3JC9FYHwo2YrTtIElsXcPfIGULLbL4za1zhGOBwB/7PujPKJ8irwl6R3dkTI0yGiGmcGOui1PGhpDjoO+wQQwwLPN/GR6HeAS+ZfJf5JgzW+mBGLKs0BkNqLH37tDzZE0tspn2zP4HRfEJW7VhDs9FoAfJrreLibqsQ6+NpI7L6ecYUbaZK0h+Nbe0duNDsUiSdpjH0FSQfztMIAa0fqRqKJf0QWjarT7O7QEXue+2NhbmyCKMoQDAvXl0dyxmmIUUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faH+ZdOSHcbRdRdzlqZUHUvaOUH6FgnBYQSP5OiHSP4=;
 b=Dr33FREa4S+8yY0qzIYubAKvyvblySnwxBXjVdm+B9Mhdrxhr6jZXL4gpUAzn6Cv8eyFRPagagzNzKJyACBKaOy1GqesqRkZD3sc7ede93L9o4dIh8BK2Kc3kuO8YBUT4pvS3kUPyK/1eAewp7OFSn25BIFMbTIUgOlz3yqucn6hfdqs5S5YXM7NAOl9TIOBQ1+LXfn9+KGcgLqXIteQOxg2r/a6q45kLeeAs1yoIPLOz1kbJ9a1x7OlkLnk7gbG1dSntG2S5M2jVpzZpODhdaKCLxQ/+Mm9sDHtzh+0GqXQYze+cfcOS5o2jB1lNLZCgUnZ/9fC8J1+tl9P3xripw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faH+ZdOSHcbRdRdzlqZUHUvaOUH6FgnBYQSP5OiHSP4=;
 b=DZGstwTUjJp81WJC/rHjrRQte8wYqJJ54n5M3YuFvKAvil91b40KZfVQ+/hprAOYos+833A6ta2YPlUDsJvBLCdlJ58HhkreGctzPhQMYZIIV4PnsVoIccg+Hdc1XIHPjRtsnM/2UYpxQ1X8AeuVajwQAtfCdbRCtDSa++Xoja6IF7+pW2JJen+jjlAVuDxWOEvV/i+CWzVg/Ni9BqEc1d5BeiQ+PrniPe6xR/F6r1FIxbzLzxJxoCBkPT2L1Q8vD4KFsF4rFn7hSps78CEB5DbrLAz4yma4AIO4RcyxJ8K+w0atKmM3PPc6CXkzY76/cYHVaM3Dqo9tDT8hKpOAxQ==
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAXPR03MB7807.eurprd03.prod.outlook.com (2603:10a6:102:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:24:25 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::dc5e:955b:bc0d:4fa5]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::dc5e:955b:bc0d:4fa5%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:24:25 +0000
From:   Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: AW: AW:  [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Thread-Topic: AW:  [PATCH] Input: pwm-beeper - Support volume setting via
 sysfs
Thread-Index: AQHZh0FVUx9Hdy7uakKOXPxorKv9ZA==
Date:   Mon, 15 May 2023 15:24:25 +0000
Message-ID: <AS8PR03MB76216EADE882B038464E9E76FA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
References: <20230512185551.183049-1-marex@denx.de>
 <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
 <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de>
In-Reply-To: <a5293af4-8d02-ed8f-52d1-722c71d47f37@denx.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=true;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2023-05-15T15:24:23Z;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ActionId=cc5e56f9-8801-42a1-ad39-867c29a350be;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7621:EE_|PAXPR03MB7807:EE_
x-ms-office365-filtering-correlation-id: 1900b98c-0bd2-4647-938a-08db55587794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9opRqoSetkCzbH98IcOuRgsBYNhINgvi28LcOhyeOH1rWBc4yBDInNZhyFTDTt/JoRrvXDVeTQr8+dlj7FSEP6RlZoWZOsrBmDLLf/D0kbp0v1fd9UJlEGfzdA5npC1KMin5SEq9yJ3zGhkPYPu73Dz7TBJz80dtuIgwErPnnH8kWq3m+4bT6IsE0T77IXqswGGx/nqnUFwUAX3slqODILS0JEFGIRzUlzIvSPOZuNnNAPlNk4lzeijMBMF4mvfWTE9mG42idJozbARQAsxbtGT9brpNfDdae+X0mcG/4OYFRIYPEN0NBXnsyf7uh0ZxvQPMg+Y6GoHB3QHzQqc6lhYxWvAUUvsgUe55e80mzU4pg5s+cZDCLVnF0WkNPoCmBl1UAEnk6twf+QnZ7a2Oy55ncXNwrPWeWwl7rIGO9uzsODs1/taUDWv3nJWGWGgruHs87iBGV4dELY1pdfwIrNBg4YVNRfZ0o7FN1sy7LKn4xuYlIhqzkf93UXoO0UNPkeul8Vh8ysqhzM/PQ/QEn3kP1omwW/e+eso5MW6BIBQJADUSdl39FV6ccZX2auY7wkzxAVZeoUWm3VDH4AeDYLgkcyZSegFEIgIuoZ5Kao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(71200400001)(122000001)(55016003)(38100700002)(186003)(26005)(83380400001)(9686003)(33656002)(2906002)(41300700001)(6506007)(52536014)(5660300002)(8936002)(8676002)(478600001)(110136005)(38070700005)(7696005)(966005)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(4326008)(86362001)(316002)(54906003)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MExKbU9QRmVHYS9SZE9ZSURDU3BKdjU1K0pSeG9HSmJFU1ZJd3NEK2dSckIy?=
 =?utf-8?B?aTBsRU1mbC9QNVpSZ0JaeGlZVW5RMzNLZ0VvZE9JNVd2SzNkSDkwNDlEczhH?=
 =?utf-8?B?NjZtNWlqZUU0RUkvZTJaUVNnMVZlTmtnZlZuZUl6NmQycU1IQStqMEVzSDBl?=
 =?utf-8?B?clVDRkhPcStHT3RwbkNDOUpuWk1jdEhUVENXOWlnckRXOUtZalZSNDNaUDVB?=
 =?utf-8?B?L0JqWk1GYnR6bVR3TUg3cWlVUFo0cTNrbDVicnRnakFXeXlzd1MzWmV5dWNW?=
 =?utf-8?B?ckk1eFpGbFM2L0l5aS9STXZDa3hHTThuNFo3RlZYMERTM01WKzFHT0I0VVpy?=
 =?utf-8?B?NmNNeHhuYzY3S1p0VXo0eGtTNE5qV2t4REliV00wbTFqeW1JOUNkRTM3OG9H?=
 =?utf-8?B?M2MzV0tYeHA2Qi9xallzT1IrWm9TYlFpcTcvdXhIblNaci9mKzJNQTlDdmsy?=
 =?utf-8?B?ZWNuNXg2SGNPcTZrcTh1dmpFUjExMUxoL1BmR1JBZm0ySjd3c3NLQkcxeWsw?=
 =?utf-8?B?U25hUThkSmVUeUc2UnM4MjJac1JQYkE2R2pSY0R3SHByL2FoMUV2OEh2Yk92?=
 =?utf-8?B?WVV6SFFXSEhtYVhzVEp2aUliek9iT29sOEw4OUV1RUJmejRzNTI1Mm05TW8y?=
 =?utf-8?B?K2ZPR2xORUVyRTZVdjhEYWp2VTY4bFU0bkN4dG84Q0RmR0kvb3UzOHk0WkVs?=
 =?utf-8?B?QkpFNkVDdDBydFlQSjZzUldSMlVGTzV3RzFRWC9QSDRnWXl6WjNVTkcrRmI3?=
 =?utf-8?B?ZWJNMkFvODMyYkxnaysrOWp0cjRLMEk0RUc2WDh3bS9xeUJlUzQzLzRkVU1B?=
 =?utf-8?B?N0piRXZmU0syOEU1ZllpeHUvTGM2MnF1azE0amR1NU9qa2N1YlB3ZzhUV2l6?=
 =?utf-8?B?bzJpKytzdlpRVForaTJwQ1ZZUUNnR3U0bXhRbWFxOG5IblJOM3RMaWYyS0do?=
 =?utf-8?B?WVBoeHdoZzNlNFJsRU5qbEwyN2ttVkl0K2NnTW1DM3kwbmp1c1k3MDlXVDZC?=
 =?utf-8?B?cVhYYzBrZGhtQmJ5b2FqcFhPajYvTXZWMjZsaWdsWm1nTDRFeVpHbC9NODhC?=
 =?utf-8?B?MmRRMXVyNGcxYktENDRaU0FEQkFJQnpjSHdVajhMWTBDbk0wOENvK1dILzd5?=
 =?utf-8?B?SnlCUytDYlJkN0JSemVsRDdWM05UQllFMDBqOTkwODE1N21FN0JKRmYwMDBs?=
 =?utf-8?B?WitVVTNxNllxemdYTUk3WHRYNzRzUVVNWU9aN2F4K3F4a0dXV3BRNWdIbVh2?=
 =?utf-8?B?emR4VDdjOTVFUzJWOEllQjhqSG55TmhkVmEvYWR2MjVSdUhhRVBUc0p3dlA2?=
 =?utf-8?B?M0E2dVJ4V3pnWUlSN3RxZFlaZlBPK2ZNSDdBNlNQakZkZE1ESFp1ZVVaWDBF?=
 =?utf-8?B?MlRsQTNHU2p6dHc3RE40UXk5N2hTUXhYOTkxNUNUbnZmS1FmRmVyMno1MmVV?=
 =?utf-8?B?bDVyMXg0d1lBSnlmZlEzVWU4ZmhrdEt0TDZYUi9xRG1kMzBxV0lNZVFFYW5E?=
 =?utf-8?B?NCtIUVZXbnoxMi9qSHAzT3dISnY5NWZDR2I3cVhOOE1xc3FTUDhWbUV6Y01Y?=
 =?utf-8?B?My9GdVBTNGwzWW43VU84SXRTYWVIYTBObk55YXlOVG9xVkY5ZEpFZVVtWm9x?=
 =?utf-8?B?V2VidCtBRURXNzlTKzdLTFNGS3pHc2M4SDlRMkFNWTc0WHh6SUlhMjZzZjQy?=
 =?utf-8?B?ZWxRYTM4YUl5MU4yT2o5bVZaQnVzdHkya2RCU3dIc2pLb0UvMjRuWGQ3R3Bl?=
 =?utf-8?B?NnFFSFR6SG9kYzU0cXZKWkJSempwYXdDUjRVRHhhL24vREdzY2tCRDlvSzBU?=
 =?utf-8?B?OEgzendiL3FobUljR05qOGV2enZKVUhvL0tzWjBDdXg4SVZCTURuem9yWEtS?=
 =?utf-8?B?eW5aV0JuczFYOUFNQ1hGbXQ5MVRWbndqZnFLQ2lFTENlOGdtd0hkU0dxNW9U?=
 =?utf-8?B?QXlhblFvUHlZanN0SnE1TjhxSWpJM08yYnhPMGpmRUdUM2JvZzZWOCszd29v?=
 =?utf-8?B?ekFsRlhUeENZRTl5SzErT294QVdaZVVDdGpNTUZuMUJhY0lUMDJJS0UyTHRQ?=
 =?utf-8?B?cjZXRG9URUdaSjRiTVY0VFRaeWVhdEJhd1dDVGtidzUrODlnRkVNVnl5NFdH?=
 =?utf-8?Q?E7hQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1900b98c-0bd2-4647-938a-08db55587794
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:24:25.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P99R4Pfm9NqLkVgrgyrOwEW0f6NIDyg8fWCPP+YKVi+Ak+5adbIbQBBmSrUQcHq07ceas1a51aE7zZje/zpM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTWFyZWssDQoNCj4+IEkgdGVuZCB0byBub3QgY2hhbmdlIGV4aXN0aW5nIHVzZXItc3BhY2Ug
aW50ZXJmYWNlcy4gSSB3b3VsZCBwcmVmZXIgdG8gaGF2ZSBhbiBhZGRpdGlvbmFsIGV2ZW50IG9y
IHVzaW5nIHN5c2ZzLg0KPiBJIGFtIGluY3JlYXNpbmdseSBjb25jZXJuZWQgYWJvdXQgdGhlIHJh
Y2UgY29uZGl0aW9uIGJldHdlZW4gY2hhbmdlIG9mIHZvbHVtZSAodmlhIHN5c2ZzKSBhbmQgZnJl
cXVlbmN5ICh2aWEgU05EX1RPTkUpIC4gU28gSSB3b3VsZCBiZSBiYW5raW5nIHRvd2FyZCBhZGRp
dGlvbmFsIGV2ZW50LCBsaWtlIFNORF9UT05FX1dJVEhfVk9MVU1FIG9yIHNvbWV0aGluZyBhbG9u
ZyB0aG9zZSBsaW5lcy4NCg0KU05EX1RPTkVfV0lUSF9WT0xVTUUgaXMgYWxzbyBvayBmcm9tIG15
IHNpZGUuIEJ1dCBpbXBsZW1lbnRpbmcgc29tZSBsb2NraW5nIHNoYWxsIGFsc28gYmUgcG9zc2li
bGUuDQoNCj4+PiBOT1RFOiBUaGlzIHVzZXMgYXBwcm9hY2ggc2ltaWxhciB0byBbMV0sIGV4Y2Vw
dCBpdCBpcyBtdWNoIHNpbXBsZXIuDQo+Pj4gICAgICAgWzFdIA0KPj4+IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1pbnB1dC9jb3Zlci8yMDIzMDIwMTE1MjEyOA0K
Pj4+IC42MTQ0MzktMS1tYW51ZWwudHJhdXRAbXQuY29tLw0KPj4gDQo+PiBUaGlzIG9uZSBpcyBt
b3JlIGNvbXBsZXgsIGJlY2F1c2UgdGhlIG1hcHBpbmcgYmV0d2VlbiBkdXR5IGN5Y2xlIGFuZCB2
b2x1bWUgaXMgbm90IGxpbmVhci4gUHJvYmFibHkgaXQgZGVwZW5kcyBhbHNvIG9uIHRoZSB1c2Vk
IGJlZXBlciBoYXJkd2FyZSB3aGljaCB2YWx1ZXMgYXJlIGRvaW5nIGEgc2lnbmlmaWNhbnQgY2hh
bmdlIGluIHZvbHVtZS4gVGhlcmVmb3JlIHRoZSBwYXRjaHNldCBpbnRyb2R1Y2VkIGEgbWFwcGlu
ZyBiZXR3ZWVuIHZvbHVtZSBsZXZlbHMgYW5kIGR1dHkgY3ljbGUgdGltZXMgaW4gdGhlIGRldmlj
ZS10cmVlIHRvIGFsbG93IHVzZXItc3BhY2UgYXBwbGljYXRpb25zIHRvIGNvbnRyb2wgdGhlIGJl
ZXBlciB2b2x1bWUgaGFyZHdhcmUgaW5kZXBlbmRlbnRseS4NCg0KPiBJIHdvbmRlciB3aGV0aGVy
IHRoaXMgbWFwcGluZyBzaG91bGRuJ3QgYmUgY29uc2lkZXJlZCBwb2xpY3kgYW5kIGxlZnQgdG8g
dXNlcnNwYWNlIHRvIGRlYWwgd2l0aCwgaW5zdGVhZCBvZiBzd2FtcGluZyB0aGUga2VybmVsIG9y
IERUIHdpdGggaXQgPw0KSG93IGNvdWxkIGEgTGludXggZGlzdHJpYnV0aW9uIGRldGVjdCB3aGlj
aCBtYXBwaW5nIGlzIHJlcXVpcmVkIHRvIGJlIGluc3RhbGxlZD8NCkZvciBtZSBpdCBzZWVtcyB0
byBiZSBlYXNpZXIgdG8gaGF2ZSB0aGUgZGV2aWNlLXNwZWNpZmljIGluZm9ybWF0aW9uIGluIHRo
ZSBkZXZpY2UtdHJlZS4NCg0KUmVnYXJkcw0KTWFudWVsDQo=
