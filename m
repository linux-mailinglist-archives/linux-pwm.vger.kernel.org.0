Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421D340671B
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Sep 2021 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhIJGPn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Sep 2021 02:15:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34737 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGPl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Sep 2021 02:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631254471; x=1662790471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=skdtyfxK9EcAGj1AD0Ch6PXYBMZ8qUxUuHmAXnL4maw=;
  b=VT7vOwCUjjW0jNYY3Ns8LdU4PRUWFrfZjq0uYWqHEBw4ugCGC+nZytui
   wu+xdswnVRpV9V3A2KXXxv9Z0wU8TZcXufLknLUUNcVTQIM8HHlrwPcUN
   fcJtraTvuPvomVCOMuo0cNC+Ieqva83YzrNNl5G4FbVJfvWN7OE3XszxX
   uji3yD5qLMMJRjB3iP53cz8mS3jU1jdSM7tLspXf0eP2jApQ6oXlQwo1j
   1uIiPEblsNGDQpL2Zv3EJOFChymL3EMTIIEy9eWXcoQeRdCQh4BQjt3eB
   j9wOaD6mQ0c8IKgYmgOLXQ8pE5qWWBC2s0pefI+N3uBx2mD+N79Qm7pki
   A==;
IronPort-SDR: Yy5NzoSXQNw6mgCMU9eaubwOojAcXBK6boWErRbaRijCSkL9n7eMxa4Xmx4RTBKbXBX7mnApcG
 lBL0IMbvLjyXdqmlJsXBSLofuIrWxM+ntbTiNWuaY3PhplNNGVuy3IhjZ4DZXqHzu/6y0KNPZT
 12RNZ8bsrD0HhqASxGDQAdbt42NNYdqZE1rKpCGXAiLsgRTAzSzihOUghDr79dv3EEiygzrb/j
 3X6Tyh/wO/r6VWJLwGqis0qL9chENHbSHXvNOhvgWXiiF8TmTsHCsvg1EkWuMIOt6TAr+07Gr5
 qZpd67OmbTmDm4rjxgNOQUlE
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="143607571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 23:14:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 23:14:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 9 Sep 2021 23:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiYkIuI/xI26vjoU+sNMJuboIx+gSTqa1Vfubn+UjogwomibPTVjhPjkkZNYzzC0Y3TX8WghbAFi1h2qNJwYCqy/6WMayvvGf4V50KIZaLspBNw3cNt6hUX8YyQAf0UHwKAQHYcYj8SeHXc3E0Sc2QsQqzn2YmP1HJA4mLQ0oiPPDZLS3lc2qglEjYPK9tdZ9hoTZ4jkPs4Nw9o/5+NG6992Yucp1xxajs/GMBxRuoxiqWfiJuHDuvd1BRl9aD0lU9kIaQ2ElEV7JBH7BnC6SUi1ca7gIi0DnruN7vAHHPErYZbE2cl95kR8GqkwN0RCcCqpH61tSFs63MDLdic5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=skdtyfxK9EcAGj1AD0Ch6PXYBMZ8qUxUuHmAXnL4maw=;
 b=Pziz4BzoLmFvyxL+SJAhux1XNoFU1N9MSOp9peiT8yCnpQY3QaaI5TlKFA0QxGuHD2xIllKWvARZszfflZLmCXOjMrrXJCJtajPboNj9eoZUtuaGwCC1h+JAJ9qgyL2twyj7321O+iiCd8JBTcYT/P5qykoXVcQ9lNS4syFwD07vT0cESAHUx4qneN2WK17I6KivSA19KSSMAPjouFa4owvAeOJzw5Bh+Fo5fjmwSTyu1SuowVQiL65iQKVnSVATStHaUV4Y2v7pmgR+ynfZA9UnoGSr8tigpIcKIWi6/uQ0DvMFOcy6pCI+f1Lnxh4gum+A+ax5yKwcbGErF/tDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skdtyfxK9EcAGj1AD0Ch6PXYBMZ8qUxUuHmAXnL4maw=;
 b=kYy4nHC4wk+dgSXaBdkEm4Et+KKHdtg9zZPhbDdhHafPKj4eryXXNDd8L9e6hrXITui6wvMhsg/z83IYNy2ySp7DPSZeH9enOCaiD2/7FllxQvXN8W5Tyq/ekpCR7uIpbhMS7Rm4TuqMj8hXTKjj4kGYaJDfM2XM+mClqy23J9g=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3705.namprd11.prod.outlook.com (2603:10b6:5:136::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Fri, 10 Sep 2021 06:14:29 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::acfc:87df:5588:8a78]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::acfc:87df:5588:8a78%3]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 06:14:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH] pwm: atmel: drop unused header
Thread-Topic: [PATCH] pwm: atmel: drop unused header
Thread-Index: AQHXpgscP+kDJtY5B0i4YkxIfrIsNA==
Date:   Fri, 10 Sep 2021 06:14:29 +0000
Message-ID: <d0ecd483-32d8-3590-85c0-eba976d49162@microchip.com>
References: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 650e8d3a-acfc-46fc-ddab-08d974223f78
x-ms-traffictypediagnostic: DM6PR11MB3705:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB37052DFD67C10C34A55988FA87D69@DM6PR11MB3705.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:216;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBN5x/BFYoa5RFlh5GeQA3zQMMk0A42pjwi/pR2ooVDHbIvOFzQ4aszy0BqiEwimWBSIRMJ5MkP1XJlxvX7NFGTOC/h/00rLkTafhasw+zFJvTYzrPJkoCFNMtwU7yF2qa23Qpr9dxYxuSV2i9UZg39CmbgiLjy4OMYt6tal/xL1H9a5YZmYu5wPm76fH7JsNbYdG5/djd7tg0xpX20ZG/BkuWfOfSIzwXEeWE7hm56lInPFahNAwbvbBmG51CLf0WPP2k1rOqJhrFSnaMEPTE8o0t3GBFFyy9PR4uxZLIw4x0xF6kxzQcLfTc7v/rBNHx2nG9gr13UvFfV7rOr/382TnVxBVW0Z1d1eWat1N9HXKWrE/lE0hjXP/vWjETstPC1vuswvsKjQYLMkMFLSnXh4NoHJiZ63T/WGgPeRWc/KReZbwcYE3gOD4hJJFuyenZyQq9q1zrcMvyNTmvX1dZj6z7wo2YneI02BNW6JxjecgDAaQ+T34wfXw506BSbpkJCCoZJ2qbdvmhY445H11k0lbQ6ASU1L/Ml8SMEnnp3456PHUXCQULLY0wrqtGx4OOk41fChQkohXQdT746SAtTtk11JwpEIWbDuYZdLPX4JxP4fdB9NGnuWMkBu6M4H8MgC4IAaKHHwVXCNEyujYPnFLyPgmqmmHGzxjw6SnYJaOdARbuJ2hRaAqDJUS0LD8G4knDunxvYtJWFPo7imqj1WmjrIjuc3wlA8oOSxOUcy+c51ZT7rYgTU2f4XYPjF+Ar3WwieBGXdkYNygb9gUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(396003)(366004)(6486002)(53546011)(8676002)(66556008)(66446008)(66946007)(66574015)(478600001)(6506007)(64756008)(66476007)(4326008)(76116006)(5660300002)(38070700005)(8936002)(26005)(186003)(6512007)(36756003)(2906002)(71200400001)(86362001)(83380400001)(316002)(4744005)(2616005)(110136005)(54906003)(31696002)(38100700002)(31686004)(122000001)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW00Nm1MOEtpZUxzcEtULzZYUXFjai9WSmdRY2pvbUhmNzVLcUY3T29RcmJ2?=
 =?utf-8?B?QVBpOVVza29xOVppM0FvT1F1V1hLV2pwS3NCL011eWNlV09VejRZdnIwaVBE?=
 =?utf-8?B?WTRVVUJ3K3R0QnBMaTFQNldJUzZRaHIwVzd6WnRmYmxhZ3d5MFZrS0g0ZUJD?=
 =?utf-8?B?Z29Ha1BxWEZXWnNRZFE0SGc4OFVrUzhXL0NPQm5tN1VJWHlqRW4zLzM5WXI4?=
 =?utf-8?B?VUhFNmZKaW5GZGdNbm04bGhXRUkybGo2UjZNdE9PRFZnb3BEOUtNNXllcDNv?=
 =?utf-8?B?T1Qzb0lyNWpJcHRCRDBwVlF5NmFOVDJFeEVpaDhaK0ttWVBvb2xPb0xjUjRN?=
 =?utf-8?B?SC85aEN5cjVFT3ZNNnU5U1RzZ1BrVlIrVW9uNTh1MS9zZUZIYWZFSHZsOHBx?=
 =?utf-8?B?N2hEOGhsQXdlcGFROS9wbDBzSGJhdzNDTFRpRkJsUG4rUXN5QmtjZDBYSjJP?=
 =?utf-8?B?RXU2NUF1dllwUG14blViaFIrME13VmlMUnBwOXBVZ3VzNTlNMVZ5aXZDeGdF?=
 =?utf-8?B?YjY5Y1p0clMrVjNzSVdSNEJLWVJLK3R5MTdudlJBSCtYcWVsc2p3c3NDM1ZX?=
 =?utf-8?B?STRUeEZ2YjdNck4rMTN4UTlxbHNzbmtzRnRHdkdQQTNMaEdwWWdlRXRrNlhL?=
 =?utf-8?B?QUp2alMyeHJ4cXFNVUlJcytzaTBPREtyOUpKZDczRVVSbUVtakJOVUhzdzVE?=
 =?utf-8?B?TGFadjJEWDcvOFEwdGxsMW5RaHAwdTNVOWNjeHdUS2Z2SEtsNmx4b0hkVDN0?=
 =?utf-8?B?NWQydmh4N21xU3k3UERRYWI4R0o2VXBpM2tWWTNUcHZHR2JPZ0VLYTN0Mmti?=
 =?utf-8?B?RzFlTHdUdTRRYzl2TURCM3ZackI3blRnMFJwTFRHK2gyUE41MktvRDM1YVMw?=
 =?utf-8?B?QWszeVVmNDNMMWtTWXVoZzYwUFBqTVhVVFJDYUNvczdBVDh0bzA3MG8wRlZp?=
 =?utf-8?B?Z3lJMVhhcGVrSm1jY1NuZkxZTWFkelFmMGdFR2c0NGdtOVVNTStkV0ZCcGJ1?=
 =?utf-8?B?amp6U0xQRkRNSU1DTVZrTmFlTDRGd3N6RmliNDIvMnBkT1FLNmhFVm1OaERw?=
 =?utf-8?B?cHQwaXVtQTNQd1Q5cFdLZGpZUmFqOFh4RzZpd29hdVczQkZZaG5laG0vZmdh?=
 =?utf-8?B?SGhocmZZYnRPa1pyaDNIL0xENFV0VDRoM2Q3aEV2aEx4VkdZRWRWZGdxMXhs?=
 =?utf-8?B?NkxCbm5EWmwwOStaUk1zMFBNbVZyVm1KSVdiWDRGRHZoMmw0dzVZVUpaaFho?=
 =?utf-8?B?OUNLaFI0a08yZHhHbE9zeEdiOE9va0tDaDIxUXJ2RmlMekZ5NDN2cGdMTVox?=
 =?utf-8?B?aThpU0xJMkhLTno5ZDYrNnNSMlNQRk1NcXFvZE4xK0MxTk9pOU9haVhXNzJV?=
 =?utf-8?B?NXBzOUx3a0l3NFRHQUczWFRWQmlISEhtNHJHV0phMi9US1RHVzVpV3I1Rk9u?=
 =?utf-8?B?QmV1eThDanBoZzcvRU1wS3pYeFVjenVydGFOK290TncybVBOUHVmYWNXUnNX?=
 =?utf-8?B?dGZwVjhkZXpWM0d2d3IxZjl4dndOWkQ1bWM5T2t0UE94cUdNL3kwdWMyOHdF?=
 =?utf-8?B?NlJjUE9Oc25zRWJrUDJFc3pzVGtjNVFBclFyOS8zRUcyR0htclpQd2ZmN29a?=
 =?utf-8?B?eU5IYUlweFA0OFRiTWw5aTF3WDA0NDVIc0hqNGdiRmdveDhNUy9ERTUzRW9U?=
 =?utf-8?B?T1JzdlgxbUhFN3gxc2o4aHdzNmF5bVNkMUREYWEvdWpIR2NjWDcvT005U1oy?=
 =?utf-8?Q?nfq9kWhrH4azZV0Jlo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6AEF4FB2C576249AE98722E2ADC3A63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650e8d3a-acfc-46fc-ddab-08d974223f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 06:14:29.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btgsnqu05H0V1p244lIPx6a/9bR9k/IN3GG4vNY2Co3tX3tapT5tb3qjFjLDOuqRgdOqD7y12JR+Ufa1WyOtAa3mlHXUVEbW16pktBHb0jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3705
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMDkuMDkuMjAyMSAxMTowOSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gU2luY2UgY29tbWl0IDUyZWFiYTRjZWRi
ZCAoInB3bTogYXRtZWw6IFJld29yayB0cmFja2luZyB1cGRhdGVzIHBlbmRpbmcNCj4gaW4gaGFy
ZHdhcmUiKSB0aGUgZHJpdmVyIGRvZXNuJ3QgbWFrZSB1c2Ugb2YgbXV0ZXhlcyBhbnkgbW9yZSwg
c28gdGhlDQo+IGhlYWRlciBkZWZpbmluZyB0aGVzZSBkb2Vzbid0IG5lZWQgdG8gYmUgaW5jbHVk
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPg0KDQpBY2tlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3B3bS9wd20tYXRtZWwu
YyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jDQo+
IGluZGV4IGU3NDg2MDQ0MDNjYy4uOThiMzRlYTlmMzhlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiBAQCAt
MjQsNyArMjQsNiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiAgI2luY2x1ZGUgPGxp
bnV4L2lvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+IC0jaW5jbHVkZSA8bGlu
dXgvbXV0ZXguaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAt
LQ0KPiAyLjMwLjINCj4gDQoNCg==
