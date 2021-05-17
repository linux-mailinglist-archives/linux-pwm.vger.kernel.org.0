Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A733822ED
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 04:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhEQCzD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 May 2021 22:55:03 -0400
Received: from mail-eopbgr1320102.outbound.protection.outlook.com ([40.107.132.102]:46315
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234039AbhEQCzD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 May 2021 22:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAKNMrO9V2pWmawDg063o4+H+/CIffYoLTdaWbGlbDfFyz0kcDeUjMAspsHZA5UY+SdsP796fJZ9LUl5n6QpaPq+ENEPZcJXzVUJehiv7qxmJw/A0/QX+3F2a/KouZjvM41isqE2O/d9FkyeO1+busTa5hNPE4fyPcmgkzpTe4u1NnFq33BrZPa0h5c8mz99rKLTdT7ku7GUXjOu42SY/rfUdbEekzOGDYbxgQgLlM66ysii8mOTtF3Y/v02peKCBHYgVtKiCihXV3PosIS42eHgDbMW4UmNrO0cfpVaWxDsTJpVSZcLjb17h+Kco/q1a5NoKM7vcROfAxUzBEcTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKqDZhWZ0JG8IWFnWwZLYhXk+Mwv592Z7NCnVP7jW+A=;
 b=K1wUt2vCvFnZBuXSxau7m2XqnfpoU6+WjCL00x35KD9sELzzR1qm4rr39Rhs1g82eIU32QP2I6xsWiKDoOJLCMLavYhAL1aly2jl2wRMnkvzPCVcJyh70wQF3QaXHAmeS1lIOSmZk2y0135yygERObgyHc3FwzOxzSXc9fEwbFRGcX5OqedW5DH7aUG6+n7c45boFiN8FzFINJ++AQYCb2fqZGRNsV3jXXx1rS3LjfOUp6zOgOgzr49a0euLTJ0TnuqqHds8x2Wpxnf482Ph5LkO0rTnZslio6waoMybVF1+c+yjdtVIpptYhjI33dfvJLi+9hiGpEyYAihkQ7ILyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKqDZhWZ0JG8IWFnWwZLYhXk+Mwv592Z7NCnVP7jW+A=;
 b=TYEWyHQX+UUJE3k27VoNhhv946fWMWnNJVD28DJyfumLevlkFbAjJCpoLXtREbOnhqcN8p/hiwMVxXb5p55dW45tkE9CJMW7k/VEaJF5197b544zY/IuPp1x44qL9kDwAaj+cUlwsdaBRVmyIfS8KiEqo6+iksQrVg+4vVdrFHAXtuTDtfG2b0CFKfOf4k+ltO3MnaVmg7fDQ4ootNu5r9CmPQLWBZoDQExrQV4H8iQfLp/ld4C5cShbnVRShJuRGO48XGyozCrTjT1m8x/h31TkTqxXWpgo9x2LFilULnl0zrWLFtXuXXzavEr2n9QsOc9x8biRvqW4nTEig9PdUQ==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2211.apcprd06.prod.outlook.com (2603:1096:203:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 02:53:44 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 02:53:44 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXSGulcCg0aX8h/0K5uaOliF3ibarkqkSAgALasoA=
Date:   Mon, 17 May 2021 02:53:44 +0000
Message-ID: <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
In-Reply-To: <20210515151827.amiqh6j6brv44jif@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 617d6dab-8e55-49d3-207b-08d918defc3c
x-ms-traffictypediagnostic: HK0PR06MB2211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB22111CD0DECE65586634BDED8B2D9@HK0PR06MB2211.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2JFr8/mLZXOifG9g1xqNL6/KurtT0pSRu6BY9peSrvPi+FZ7846d7f0giqJ1e8TOV/7jj5pBTXaK+MnT9JfrhDP3vkVRwXDWSsK5et0ZQmxOYiJ+yyF97lmWwM1m1E7EkOa2B3D9N7XlFz3X14gGcXt6qbmm4QgjmYj2R+O5jq8nOfU31GwLosr9Vj1LJEpIGLQyk2DlyqMHHOeyA6vQ1nBLhh+mTFxJ6bx9BMCI//cmjNY1oPzWUM0mbhyKR6MeDZCdrphYxm/Ar3pBTDpHQ+NywFHJgN1U9wKl6JkjSHWWAHL8iGv7DsBxx/Cjl9ocp7uHNTk2eqsYCuHK8frEajx8mSpyKFFwAGS8FVJPsDeV1ZVInDKlVuQXJUoB2zipnXd7IlewKlY3sgqsin8BKSI41UwJ2I5AyeXU3lCeoEZzTirCBuUW9Mjp4vvOZ619UJVzweu0LDxc8aSYEFAhuuEcAbZoyD8SkuEovGqE9+/lOTYIZxgN5DxP/YClCe5QPCvz03Jil/sUbCIaldow+iPoQf9kFjF3vUgVqknnpJpvN90LuuBV+/XOo1bkIOC48r2ugUW2mbNYI1TZXQrHAYijBwDEzSQU0Efx2cLyvK5bDLmVW1DwDzGDhsY9ptiR/T7T+akRBUYq7f8HJ9wIkYKnbcg/Mj/ntx9clt7jrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39840400004)(376002)(346002)(366004)(54906003)(316002)(8676002)(8936002)(38100700002)(26005)(122000001)(36756003)(71200400001)(186003)(55236004)(66556008)(66476007)(4326008)(6486002)(64756008)(86362001)(76116006)(2616005)(66446008)(66946007)(2906002)(7416002)(6512007)(478600001)(33656002)(6916009)(4744005)(5660300002)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEVIa09iUUlFSG9kcGk4VGQrcVd0ZDRzMVUxT21pM0RNSzJ4SXlBVlcrdm5G?=
 =?utf-8?B?aklhLzdoNXgwYjhNTlBoS3NXc2ltQWVLckUxc211RFlFdC9sQkh6bjlVUVpE?=
 =?utf-8?B?QzRwQ1JscGlSdHVVRHB3R25Hb0k0cTU2cnZUVjB1dTRQUENzQlpFa2VpQ0lB?=
 =?utf-8?B?QzVKamhnRkczcEE5TmhIc0dmYkJablMvYk1oUEpwbzFxR3ZQclRMVS9QbUt1?=
 =?utf-8?B?RWxjN29DaTBkM0JpQVBXSDl5QTRlUWdpdFFDTWgxSXdLRFoxV0ZVN080bWty?=
 =?utf-8?B?dDgydjZNdytvek95WmV1eVZBRWdJTkYwWDRhY0U2T3hNSTNmVDNSYnQ5ZHdL?=
 =?utf-8?B?YUR6Uk5IMWZuTkxWR2NzaEtySHUxNzNOT3N0aTZwTjVMLytNRUVQdUk5aXdF?=
 =?utf-8?B?bzM2dVJZQm91ckw3KzBzSEJKYzMrcVJzQ0hDcWp5NHlCdVlvVkpKd2pySGJL?=
 =?utf-8?B?YmxUMnRjVThkL2ZTL3VQSDlVQWhBYXpibGVQWGw4VnJuQ1UzdHk1cktTWk96?=
 =?utf-8?B?VTYxcHg1MzdXRmgrL3NDL2tDQytFdzd6WHV3VEtVUUdPc1c1ZU1sbmQzR1Fq?=
 =?utf-8?B?ZFN5NlhBeEJLYllNdVBYVWFTeDc0cVdIK1djV2xDeXh0c09MUXdWak1mblNo?=
 =?utf-8?B?cW0zRGpwZEx4UERyNXU2Wm5tTXdIQ2NBVEordjZkTWlGZGs1eU40SDV2MHU1?=
 =?utf-8?B?bEN0T0g2azc5d1BIV3V0d0lORmJZcTZGUWFlUncwWEdObkN1MGVKb1dqTklL?=
 =?utf-8?B?eldyTFBzTEtyNXl5MllQMncvL2lHQ1ZBc3FJbGhkdmlLeVNZcUdQdHVMdGxQ?=
 =?utf-8?B?UWZiVE9IRUxIejA3QWU5QmpFaE9Gak9nT3VSbjBmaW5VWUdQK0psNEVWZ0Vj?=
 =?utf-8?B?ME9pZzZJMUxFd0RKQ0FYSkNQQ0RLeGxJZE1rQkI2K3AySGkycVlrUkxhY1lh?=
 =?utf-8?B?UmlwUWRnSGNKQVE4TWFJd3gzaG1vd3Y2NThiYVdWVnJ2SWtOMUUzWHpDdnU3?=
 =?utf-8?B?ZUx5UXRWYytZUFpHdzduUVl3eFIwQ0pTTHZpSVNZQ0hteUtNRHdlNzkxMFBk?=
 =?utf-8?B?eGV5eXpKbjhxUjBtTFRHYXBtcktsTFFmelA2ZWkzSnUwVFJqMlVNSEYvaFo0?=
 =?utf-8?B?d0JSUVV6UE10ZDdXZHdKYkJIRGwrQ2EwdjFQMEdCakZOU2JhVldsWmd0d1JJ?=
 =?utf-8?B?UUprZWtnUUdvY2ozODg3VXdkSVh0T0NTWlkxOGcrM3pDTHZ1NTBHdWtkVFF0?=
 =?utf-8?B?SXhUOXBPSVFydHpTNzRScTJzMWpONnNCWXIvSEZUODViY1lYTlJrM3YyZzc1?=
 =?utf-8?B?Ti9pczhTelJFZUhueDdGZVdUa0ZqYTN4ZGFmdUxXTDlXb0FVbTdyQllpUUZr?=
 =?utf-8?B?dnA4TXRKYUpCVFdQN3p5Qll5dUp2aWVYdkVhcWUvbnl6WmJvbFpGY3BzT1g0?=
 =?utf-8?B?UFN6OSt1Q2o3VUg4YkdGSnpQSGEvSzIybTlFdTdlUUFkR25LcUNtaXZvNHN3?=
 =?utf-8?B?ZDUyYWZaeHV6VW5vWEVYRlZzVHZNbEtHNitBTU02MUtkRzFaQTZwVC9SUWxU?=
 =?utf-8?B?Y0xvUnRVYm00Z2sxaDgzUGExTlkvcTJiSnhnOVVmMmY1VDNNaUo1aFgwOE5Z?=
 =?utf-8?B?L0tmOTJuOC9RUGJrY0RiOVlSaFNlRDRlQTkwdkFVeTR3a0xDa0dxZDdvQTNL?=
 =?utf-8?B?cHl1VXphbWZQbEJPeHNLdkNXd0VRM2tlZHdNczAyOTZTd1hzRmgrVUxpQWxI?=
 =?utf-8?Q?XXfPLTSvvkzbxrEvE6Tdm2gka88duxfwwcPPfRC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <028DDC2490E84644A71E36C5C6CB86FD@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d6dab-8e55-49d3-207b-08d918defc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 02:53:44.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhqsalUsMlKKffK9ETFa20YniEkyOkRzPnaX8qjr9gLMmCuB2PPtkRp92WcM8qlBm9jzvo5aozh8++kzggxyWm6HFzEFBBH0rNXqsLwxMDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2211
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGVsbG8sDQoNCu+7v09uIDIwMjEvNS8xNSwgMTE6NTcgUE0sVXdlIEtsZWluZS1Lw7ZuaWd3cm90
ZToNCg0KCT4JPiArCWRpdl9oID0gRElWX1JPVU5EX0RPV05fVUxMKGRpdl9oLA0KCT4JPiArCQkJ
CSAgIChGSUVMRF9NQVgoUFdNX0FTUEVFRF9DVFJMX0NMS19ESVZfTCkgKyAxKSk7DQoJPgk+ICsJ
ZGl2X2ggPSBESVZfUk9VTkRfRE9XTl9VTEwoZGl2X2gsIE5TRUNfUEVSX1NFQyk7DQoNCgk+IEFz
IGEgZGl2aXNpb24gaXMgYW4gZXhwZW5zaXZlIG9wZXJhdGlvbiB5b3UgY2FuIGJldHRlciBmaXJz
dCBtdWx0aXBseQ0KCT4gTlNFQ19QRVJfU0VDIGFuZCBGSUVMRF9NQVgoUFdNX0FTUEVFRF9DVFJM
X0NMS19ESVZfTCkgKyAxIGFuZCBkaXZpZGUgYnkNCgk+IHRoZSByZXN1bHQuDQoNCldoZW4gSSBt
dWx0aXBseSBOU0VDX1BFUl9TRUMgYW5kIEZJRUxEX01BWChQV01fQVNQRUVEX0NUUkxfQ0xLX0RJ
Vl9MKSArIDEgdGhlIHJlc3VsdCB3aWxsIG92ZXJmbG93DQpmb3IgMzItYml0cyBhbmQgdGhlIGRp
dmlzb3IgdHlwZSBvZiBkb19kaXYgaXMgMzItYml0cyBzbyBJIG5lZWQgdG8gZG8gZGl2IHR3aWNl
IHRvIGF2b2lkIHRoZSBpc3N1ZS4NCkNhbiB5b3UgZ2l2ZSBtZSBzb21lIHN1Z2dlc3RzPw0KDQpU
aGFua3MNCg0K
