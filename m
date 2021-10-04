Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88963420682
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJDHTH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Oct 2021 03:19:07 -0400
Received: from mail-eopbgr1320127.outbound.protection.outlook.com ([40.107.132.127]:6223
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhJDHTH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 4 Oct 2021 03:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsRM1GvJut25sd1V8bA73lmJOJu0tyAqIGPNd6Iga8gGkKzZluRuoHfW0TLxScKDk830nN6ibMfpQQYWYbI+6LlxQNvePChO+Yq1Y1G5tmAy96mKobYqOW7QclysV7Ule/vLxm/18Xtlbomc7ir8aEzP2DRbibjHMzXX/yZU775HnYMt4fKeSmkC++nmijQgfnAophoEzvblJqD/YH3e2EcLN/uPjiFJrEAq72oNqPKCMvOqbZuSsHaz6/Lv2no9Lj5sjsMsib3j/WTWEKqMYbbz0Z4Q6PLwR+06hfSjpgknhKciQcrYBahm+LWOofJ20xu9qic5EYU4epUCrr+mfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn0CKR9nn9IFgJkWUXTTAwtAJ39IGQ5+hauWUI/lWkw=;
 b=exqUHek48DEi5jKbCjkKgNnUO6Y5OWQsaBq4SwioYLzt86XukGX0BaY1xSBrnNTe2K0qfwVAP16feVqv+LSuvXaewLKOk4bOou01tfdhUSzrWYOJ75EprSWaMD/wjbAnSZ8lI7zNeiHwaXdNx8KvMTmJoiv6N21hD1EvmB9JXz5Jkgj4KXeSLghilP/bGTohz8NcXsBSmNkXX3pFCQmfzFBd7uGZawOsw7ejerGSVpfkiG5J6tHoB7NoSUPn43DV/XHY7LMQ1EE4wG0byDEQ2oscrIGRn4MaFic0Vxnr7d5c1Cg/cOsBFOF5H1AMdBfKbqf9TJq53NjeZ/SGabZE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn0CKR9nn9IFgJkWUXTTAwtAJ39IGQ5+hauWUI/lWkw=;
 b=CZga/rmNYs2s1xgSR+nuTmod5FhQCCERyODYVTKVGZ1iDq970eZUuFTKMqa2eWQkSi332IM+Lp0rlJ1fRAOucOSewSFRBmkx2siQUSZM8vCaQToCyXGNfxqBi4Ps5z9+UU6E9O239zALnR+EEYE+xKUPpw9+l/AlUH3J20+S+FA707fA+LD4apd+fzRGWpvfbukFD4G/wIMlvRlS5JrbXtEz0K8SxKFtKNmjJUIP3XRlB58uDrYhjKifrSpNqtjqderx6FzImgJE6t3nD6JXVkin230NFIAQYabI+wsNHzS5pirGFke+5uW9nzWqyDSKo0iSb3k4jQSlwDCBAZRE/w==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2961.apcprd06.prod.outlook.com (2603:1096:203:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 07:17:16 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::190:5c40:6d3c:ca8a]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::190:5c40:6d3c:ca8a%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 07:17:16 +0000
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
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXosi+3/Cp8r5W9kOmoeBphO1kxKvC1rOA///A+wCAAIiKgA==
Date:   Mon, 4 Oct 2021 07:17:15 +0000
Message-ID: <58C28D92-90F7-4915-B45C-2E9569313482@aspeedtech.com>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
 <20210906024339.21124-3-billy_tsai@aspeedtech.com>
 <012AEBBE-9FFC-48B5-8794-00A577C3C87A@aspeedtech.com>
 <20211004070826.on5tg42dvjh7bayt@pengutronix.de>
In-Reply-To: <20211004070826.on5tg42dvjh7bayt@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecf0116c-4cb1-405a-206d-08d98706fea7
x-ms-traffictypediagnostic: HK0PR06MB2961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2961CF73FC4E9389DB9E8D258BAE9@HK0PR06MB2961.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDVa09Zsuz7Ti534WNKzGsbfaGmzJ6oNq+bq2LuyvD3b0PKhrvngVxxIPXNnFUgws0C1vlmd+Oi0DpSi2ctYdj0QeMHSGAwQwKjhZt++tqx/rNBj7V6UHghHbtvMzX6rEWT8kwXg2po851wgY/8LnoU1tspAZP64sO9vrJTupqhMoVCiO0VPPh2zVCCvbQBrE3qXPe7w+yKfH6yqt1SpGIji1i9TK5cf1dbJZVJNkUoXsWgMy+1cGOdYgbGsJZ13uwjjL1vFjDY1b2Cgg8MtcLRF3d+dlDkzT7GYSQWDV9AFDK7ma9t9hCbvsAD7sZc7idRoaWZ2ZtSTEDkKP+wxs7Ez99Ii8t5IZ9ovOgepnCu9KsIgVN6Ho7mfY4HuR5y3SGVPXAtndRynvIhIh7JzS5qMzUV29RVmFZ1qb10kXgWO13Eo7IagqJN4+UKkIRUgqIAEaeH8cYy9x5LalPpoe5XhqnR0NT5feBMcOryK93jNvu15yKSclMRBggFXAJzWNBE4KoJJyaAez71qZzwWlR5HSh1T1gENCbDiiSJ4RAOXi8c0Tl0qRAHuqCHVVGpHoBkHavR8bngxy8qXBVmPL3rJ/xDccpvmrxT/URtBE89aZOx5E8F1QNHUCrf0zeoM9Gw5DjAWZNkEByYyM6Zc+SsqzztDljXPiXqr7vNhCNbhAYJDbNUhIXBta7ETPRNdaQdvXQrmQVPmdO14qWYkAL3C+3193j/UgKwFfM4Xov8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(4744005)(38100700002)(33656002)(64756008)(7416002)(6916009)(66446008)(4326008)(66946007)(76116006)(122000001)(66476007)(66556008)(107886003)(6506007)(508600001)(2906002)(36756003)(5660300002)(2616005)(186003)(86362001)(6486002)(8676002)(316002)(8936002)(71200400001)(54906003)(6512007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC8xZGpDd0UydUxPWlZsYU5HUGw4OXZ3L0t6bXY1VEMvY1JQVGZTS1FvNjZY?=
 =?utf-8?B?RTJTMGMzbzJDZ0ZyNkVwTnpNa1MrYWczbkN5VzBrTFlpOHZJM0hoZDRNcEdj?=
 =?utf-8?B?MUxIazNPWnBDVHR6TVFEWno5ekptUUpCM0srelpsSlBGZ3ZUNUxvNEFNdFBQ?=
 =?utf-8?B?N09sNE81MGN4ZTVtUjQvdHZzNWRzMlozd2RjR0ZqVUJRZTlGSTRsN2ZPSlJ6?=
 =?utf-8?B?QXUxZUZCdEtJcFZSS0NVTEpvTHprMUJCWVhPUkNTVUg0U1Y3S095dEE2UHgr?=
 =?utf-8?B?dnZUM0JKRU9iM0hkL2NFcUZSV3JoMTNyQjh1MGNmWUpzRGhCTkpTbitrd3JD?=
 =?utf-8?B?aWxsMFlrSGlRbjdZbmV6cEhXR3g1ejA0RjJoVUt0MnFpTkZhbnV1UkdXMkpX?=
 =?utf-8?B?UFNMZW9Wd3Vpbm56SzBxZUp6OW9HeldjQks2TTJOVFpYUUFGc05id0puVEdX?=
 =?utf-8?B?c05MeEpHbFpKZDRSWUZyWCtNQXg1RFczOElGNW9xWitMU2tSVXJkcG15SHVi?=
 =?utf-8?B?cHBJOG5xZG1HREhXUDRXSlUrUDFCYmhNZmFKZWMraHJzUmh5ZFlxeHVhSkFh?=
 =?utf-8?B?dS9KalovcE9hWGFSNTRqbUFQN0tqWFgyVlJCZXd0TzQ2SXV3NVdqL1NqRUdp?=
 =?utf-8?B?b3FkRFpiTmFxSzZheEplQmswN094TVV0WDZxemRHT1c2Y1hyM040bmZXaUp6?=
 =?utf-8?B?WjRaaHhDb3VNWFFDODNhdzNtQld1SEZRbW9TNUJLQ1V3R1BGTW51OXIxRFhR?=
 =?utf-8?B?Z3pIZ3g2bE5pcVJ0Y3Q3VWUyMmhVVVRLalNTV0E1ZnhYNkxuYnQ5Z2NaVEJv?=
 =?utf-8?B?eVBJUTdadFRqOElsVWp5UTJVVFoyU0o5RHY2M1VVaTBZZW9Xbysyenk5MmNh?=
 =?utf-8?B?RW4vSEhURFF2eUxSeGt4TkhxaTRldGszTTJWaE1KR09yRG9BWnZYaU9yWEN4?=
 =?utf-8?B?L3MxQnNXMVJESDNIcjd5V3ovYk9Gb0RKQkIxZFBXZjhYMHg1ZVBGUkt1MU5z?=
 =?utf-8?B?aTJqUVhjWEs2YnNPMkR4bmRqaG5TbnBtYmpVRjhHV2ora0RHL3pvT2tCZGto?=
 =?utf-8?B?RENRVzdVeXJobndoSDJPWGZZVlU3LytyZzFGdVI5YW9ydDVpcDNQcW56Wld4?=
 =?utf-8?B?Z1pneEJBZ2orcmRNRVd1eWRoYzBjOEZrRFdyNUlmcit1ZlVwd3RzSERVbmFu?=
 =?utf-8?B?RnNJeW1laWx1RTZhOWhmREFrZUorT05MWVFkVFNvZUp3aFV2elVvSXlNTkFZ?=
 =?utf-8?B?S3RXdDVmZUVRU2wwNjZqQkk4eTdYY2lLb2U5elN1aWIzTVhKMjZ0NHZWRnhO?=
 =?utf-8?B?WXUrR3ErZ0psME55dWZpN2xxWUlYTXNQUDdqRlNQSU9oUnRDOHlETmJaelNQ?=
 =?utf-8?B?Q3lBYkNLMGpOcEJnM3Z3Q2xwMmlLQ1JnTEUrT2RoRldtdVJyWGVPTXV5NTBv?=
 =?utf-8?B?ajkvdSs0NHVKRURwSWZhUVdSU3VBR2hTRG91Y3d6bEVrOU5Jd29VUFQ2NlNk?=
 =?utf-8?B?MkMxSEh4T2IvZ3VnTEhMbVdDb2hlUWVzM1lVdE1HUXRvSytiOUJ1VjY1aThx?=
 =?utf-8?B?Z0pRZTlFK0xFbDgyMllJKy8xTDFYUVdURCs0ZU44SUlyUGFKYXNrY3huZjh6?=
 =?utf-8?B?eGlGS1lZWHpERE8yaW4yVVFaS3BNbnZiWTN3V0NjL242cG1vZkFxUHpWamxJ?=
 =?utf-8?B?VW9iWlB4K3c4WUxNTzhPa0U5c0JxN2lsUW5oQ0hUUjVBREc5dGhQMTlDVXc4?=
 =?utf-8?B?c0U1OHFJMG1MN2pqUFdMUEl3VGV2NDZ3UHlRem5QRWN1YnprMmR3alFWcldF?=
 =?utf-8?B?SEVLSmZoNFBaR054MmVidz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63293FBB9D537048B6E1A1EBE812DED8@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf0116c-4cb1-405a-206d-08d98706fea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 07:17:16.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpySEql9xKwR/usfZDQ4tLK/xFFixv6vfwk8kQ2CcYBMGOoxaSBLnKhJutf+K2pLFRY8FSSVYehzT73wbdPaAYuhfvTrnKuG3Roe3Vi6B6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2961
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQrvu79PbiAyMDIxLzEwLzQsIDM6MDggUE0sICJVd2UgS2xlaW5lLUvDtm5pZyIg
PHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQoNCiAgICBIZWxsbyBCaWxs
eSwNCg0KICAgIE9uIE1vbiwgT2N0IDA0LCAyMDIxIGF0IDAyOjU0OjAwQU0gKzAwMDAsIEJpbGx5
IFRzYWkgd3JvdGU6DQogICAgPiBEb2VzIGFueW9uZSBoYXZlIGFueSBjb21tZW50cyBhYm91dCB0
aGlzIHBhdGNoPw0KDQogICAgPiBJdCdzIG9uIG15IGxpc3Qgb2YgdG9kb3MsIHRoZSBwcm9ibGVt
IGlzIHRoZXJlIGFyZSBzbyBtYW55IHRoaW5nIG9uIHRoYXQNCiAgICA+IGxpc3QuIEknbGwgdHJ5
IHRvIHJldmlldyB5b3VyIHBhdGNoIHNldCB0aGlzIHdlZWsuDQoNClRoYW5rIHlvdSBmb3IgdGFr
aW5nIHlvdXIgdGltZS4NCg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQo=
