Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69447144AA7
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2020 05:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVEAm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 23:00:42 -0500
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:61463
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgAVEAm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 21 Jan 2020 23:00:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8CaT8kkDELX+dBC8+ys9+jqyrLIusBbVzKDmoC5VA8btBXdFQsvia8VGg4wo8P4kswtNzlQ5If1fca8HSySSK5e4FnJjAsuGSQPwW72hdzoOJvkHY43qJTsboUgzn9qqnVyRmnRVKW5xkj242RoP0J89uRWT6x/jdVCJeGrBNtQpjgMVmVv7aOfX8T4Iq24lghBLcALQzrroBjep3yNi1bYF2mweavsUEJbUJJjF+3VsPP4xVmBUQP1uHSHb2U5XGOJH+WzZOZonaRgmZ3/BkzBJQWIZyCy/HaQlPKTEyina84/wPLGnuLE6SdDVLkHv4KiBNMdkN0uLjKv+79SCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crYDMoNhNe50Uhwp9FaCpI5GyAxe/u4dlGBrWl2ABVE=;
 b=NT9orMbYCgJCfH7K5dGkZwt4QvZvzWoyP5O4pKZ0E+GZASm7TeSnA5epN5mSqwZgN53AQvd137HYdHxb8KLvHhnOMfmZ5jHBGvrAZUKVJTmY3ulWmPlYnCh+jwLTeUVNHB+5MsB91UQmF+fqXw3a0PLTg7rN7xC6WDaH3LNKz746LBMlD0aSP2oPWAURIXqMQu+Oa6zg4P0B/HVk9kFcKmkf7HtEvyAQ4o3OrEk0/C+zy0s5cc/Tv6SDzq5YSm8kqhcovIjsdLS09ta91Oy8y8nJD12l9lmARWMyET8xwVGBNd3ijzgiXHs9ZcKJ4tRCaOW6AKH/u9aK+f3g/YSilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crYDMoNhNe50Uhwp9FaCpI5GyAxe/u4dlGBrWl2ABVE=;
 b=LDJBFP6P+CQLVKE6D56HlSsY1qJRFTwDnfr7kzNsk/N4VLenWJ6ucNmowKn1N7UXMnGdyCj+RAz7W+f6MP1fpe69Q7BJ/sIqe4qUCJQ+1CIic3Al7QcvS6l1R3tPLtj8Z+YzYvr+n27ED1i2zz8z8CUGJWdjKgyb1UAyLixBGSY=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4336.namprd08.prod.outlook.com (52.135.69.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 04:00:37 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.026; Wed, 22 Jan 2020
 04:00:37 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0401CA0015.namprd04.prod.outlook.com (2603:10b6:803:21::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 04:00:36 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v4 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVzN7LS9UVe3hXOEa6+dol5orE9afu2GCAgAQgfoCAADy8gIAC4aYA
Date:   Wed, 22 Jan 2020 04:00:37 +0000
Message-ID: <20200122040034.GB1455@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-3-git-send-email-jeff@labundy.com>
 <20200117132143.GK15507@dell> <20200120042303.GC28865@labundy.com>
 <20200120080025.GP15507@dell>
In-Reply-To: <20200120080025.GP15507@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0015.namprd04.prod.outlook.com
 (2603:10b6:803:21::25) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30ac4c23-51cd-4225-3b2f-08d79eefa363
x-ms-traffictypediagnostic: SN6PR08MB4336:
x-microsoft-antispam-prvs: <SN6PR08MB4336B7D5D848B1B5382BC80CD30C0@SN6PR08MB4336.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39830400003)(396003)(346002)(366004)(189003)(199004)(36756003)(66476007)(64756008)(16526019)(26005)(66946007)(8936002)(7696005)(52116002)(66446008)(66556008)(86362001)(33656002)(6916009)(508600001)(55016002)(8886007)(186003)(71200400001)(5660300002)(2906002)(4326008)(1076003)(316002)(2616005)(54906003)(956004)(8676002)(4744005)(81166006)(81156014)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4336;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GnrVHRuvZ9iCdzagNEtp7brHz8Fg24cbM7LjO4+lQnThFuOwB5XFJj4B23K97FURhBNKYs8uhGTDSg7ZKDVld91VRsyPett5bPv7Bu04Z7zsclGLpQnwJNJsrhGZN0+BZeJrZ36FkKy2UuIsaDav1Qh1xt/2pq/KT3TJNpidD2hnwVVHbu5D7rvw/+LyA2GcQ48ZmEuMT5bE6tzma/yBlDNAepZUV+eYlWkuakx9A5NMQE1ukLmHXwp1SIlbl7Nij5zFfDG8e9bmDCMpo5yrloX4zxJLgvY+nFSxS6udcj/x8ctZuU40b6nZUWUTQ7N8IgNMfgwUUrMIVZFPaoaS3AfvU+MuZy3eaz74zFKd4sgGxSF7vsx9WR2agM6brFYQt7bBZF1R4SqDwFA2n6BGh+BhAfz1ob+KwIlsL3ATiaQEyLxPNJNFpFg9oj63DSoC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45CB669215DDD74BBE895395E0D0A969@namprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ac4c23-51cd-4225-3b2f-08d79eefa363
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 04:00:37.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcYKN3OqZ17D5D+sRhAcocHeJK2AnSpRCvRGetzWJAQZQWhy6MrqKJNGeIbu3LoF8AZVFgItAj8EK8Ukq4kwfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4336
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGVlLA0KDQpPbiBNb24sIEphbiAyMCwgMjAyMCBhdCAwODowMDoyNUFNICswMDAwLCBMZWUg
Sm9uZXMgd3JvdGU6DQoNClsuLi5dDQoNCj4gSW4gZnV0dXJlLCBjb3VsZCB5b3UgdHJpbSBhbGwg
dW5uZWNlc3NhcnkgcGFydHMgb2YgdGhlIHJldmlldywNCj4gc25pcHBpbmcgb3V0IGFsbCBvZiB0
aGUgcGFydHMgeW91IGFncmVlIHdpdGgsIGxlYXZpbmcgb25seSB0aGUNCj4gY29udGVudGlvdXMg
Y29udGV4dCBwbGVhc2U/ICBJdCBzYXZlcyBhbiBhd2Z1bCBsb3Qgb2Ygc2Nyb2xsaW5nIG9uDQo+
IGJlaGFsZiBvZiB0aGUgcmVhZGVyL3Jldmlld2VyLiAgVGhhbmtzLg0KPiANCj4gLS0gDQo+IExl
ZSBKb25lcyBb5p2O55C85pavXQ0KPiBMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQNCj4g
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IEZvbGxv
dyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cNCg0KU3VyZSB0aGluZzsgSSdtIGhh
cHB5IHRvIGRvIHRoYXQgbW92aW5nIGZvcndhcmQuIFRoYW5rIHlvdSBhZ2FpbiBmb3INCmFsbCBv
ZiB5b3VyIGZlZWRiYWNrLg0KDQpJJ2xsIHNlbmQgdjUgYWZ0ZXIgdGhlIHVwY29taW5nIG1lcmdl
IHdpbmRvdyBjbG9zZXMuDQoNCktpbmQgcmVnYXJkcywNCkplZmYgTGFCdW5keQ0K
