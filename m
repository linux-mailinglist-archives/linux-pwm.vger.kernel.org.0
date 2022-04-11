Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F64FB5E7
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbiDKIYj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiDKIYh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 04:24:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14873E0E1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649665343; x=1681201343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uHPWdcRO3mjbGk7hGEgGG1kZq+HG0jEBvQzBeLlKu00=;
  b=rJnjYRLANPxBG1mKwFQJAaZpQERYxBRuf3E5U85NnycK2tI76zTRajD/
   V6p6jbvgrI9jn1R6bTsZz3VqXtLl3SRDFs0f9sjOhWicDBh2ThjivsvEB
   joQj4YkX/RWl9roFqwHLy4Txw85tj7LZZJsZINBkYM+Jiy3jrumw5mSOg
   gM0rxvtSVuMTxNdY0hVZ/eg9FMJxCtCTIuWJxWA1HLONVGxI56Sozm+PO
   319c0Zwu2f25hjHxbbzthjXAVPV3mOAzSKt/d4HsA9ifGpkt1zYIa+/fV
   1UpHogzYluaYXP4/srPhLpp2rzcJ3Jy0TMxy1x4ISjidmfPTIdJatYBTR
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="91952850"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 01:22:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 01:22:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 01:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR8dH0eoMarrCHds1FL6WMDH4/m3quZI/h7nACZK7WwmK0kw1983XZ8lquTZL/mpYbZMhRCLcK/jwZzfu02Vx25zWhoNK1ATWrDK51Ckmy0Xc6Q7YzhHGRvXkGqelAgFqAi9JPVyZbvkXXX+uQngrsXgjZhq8u3/0dElqwhLAl7QweT4jBJ7gkH7d4kH5Pq6KeBI1vuzWgLiN2fuDK6atqmNXa4KIsOVFde4/WhV3tYllGydskSrscSko9fxKSFi07A+jKI/hPEsmG8WsIgrsU9rq71PoPBkCwN8rnoFEJR5ie6qo2q1FWscdnH7Oe3vxBVbwIPMUVrJBC39vSYX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHPWdcRO3mjbGk7hGEgGG1kZq+HG0jEBvQzBeLlKu00=;
 b=jdTm1cs6Y3zkQLBODJPgSiYLNARcG0CugRljmuZkxmAP4N+qC1GCqZupw6YQHSDGhKEpaTpf2Y9ohvq7QbFk/YMB5VShLDJ0iufL/kGig9r3FswtmpgCKAcPE5ZjUwdcH6Dwgjg+I1TVhgrhujusj9xL5UfKAAfldnGvXNBmw7OJAkCRcup87+zdlbHB8N0Fgry4nMjSgeCpNywys3TecW7GK2uB2exv/6yQk9E8iEmA6t5Ftq77tt1M0Sim4lXU3aefBSAVLWvUdmV7wCQu2tTdZiWYtvWw5S7sGwQGmVVCukgROGHreBQNztYosYFLx6g5ZNcMYc2gEqVgIo1RQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHPWdcRO3mjbGk7hGEgGG1kZq+HG0jEBvQzBeLlKu00=;
 b=lm54ai805JJfDpl3YiSLUDPyoN0t/JvNUZwuG/p8J5MyIASTC5q/9o50JEFyuxdaA7IZKlQrIfiRbW09dYnZV3C88jt3DJ+uNREgb2SnnZpMsFYIh4hSzNoB1+DdOVqhNJB+0Bpfgkr7azeaDI9qKU9CpFyF2CAb5sj1A/zzLWE=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CY4PR11MB1415.namprd11.prod.outlook.com (2603:10b6:903:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:22:17 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:22:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH] pwm: atmel-tcp: Make atmel_tcb_divisors static
Thread-Topic: [PATCH] pwm: atmel-tcp: Make atmel_tcb_divisors static
Thread-Index: AQHYTX1BRLFhmaxGeUGkcHRSUxtYAw==
Date:   Mon, 11 Apr 2022 08:22:17 +0000
Message-ID: <70e47f94-c12a-d432-f3d6-0325313ddaa4@microchip.com>
References: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77420ac3-406b-402b-a328-08da1b946411
x-ms-traffictypediagnostic: CY4PR11MB1415:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1415C34F0116455120803BDD87EA9@CY4PR11MB1415.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibrn5Hk1t2PkfwTy9pqX6WE+w9fecEoDHRCdm/T9zpZA3tDxyHCg9sFF1Wgg/RDISOvQxkXuw5R0wFwC5jpV/+ikcJaEMd3cJNGiY46TUMHgk7qPjT6dQI5r1GbQjvd853KEWNVB2iDBF49EG83FbuUufvFw8H1t3DNUsngm5y+szYJUtjNH8Jh55Kz5mbq7OZtECHeNPj+YBDgHT3MkAlTwXT2Qj/qGLKS1sjCWE4HRiXyll2cMg8/yxALhtlLsU9i1UWIrmbcXj5YDBb06vlp1X0+Gq0gyTE6H4rztcRbkdnfEa4l2ExJW8QnAhe+lFuVE6v9lrPygXnZGhtCM+zFhyubUUnbi0kXCPJ8AD3jKg6G7SbiowqJh68iSx3exSeKxdHPTAwq1mqVtwiqDg1vG57N2H7tkMpw7rokDTFr5sGrBmYhBDbQQ8H7GswtUpsg6+aITjtL9rfveeFYwWNyHExeH20cDorDNEmy4xAUXBACX07a20oLdGGGXxlJeORRtnSbETItW9tB8100IkGnTUC6hIUveXa77sB6CGbYgpwt2JfajM3kvbbNgakLWY2QZ7/m1CJ00nY9ISypHhtw2NxMhn87DRF8ZNWLMeDrwcibmKrf1RKhcXBOfJIoIj+rrRQJ+q1AdOp/QCEuTaxmqPqpgbne2JThyZ+//z4DxUM97F2gz1B8/8/xwk5AtqTo7cwavzDdO2o/oIpEKaRsJIENgx5UfD4PIov4yyZdsSU9V7qF9jrJKAgiNzZp84nOr3Ga75lSHC0s5RCmVZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(316002)(66574015)(53546011)(36756003)(31686004)(5660300002)(6512007)(186003)(26005)(83380400001)(31696002)(66946007)(64756008)(8676002)(86362001)(38100700002)(2616005)(508600001)(122000001)(66446008)(4326008)(6486002)(54906003)(38070700005)(66476007)(91956017)(66556008)(110136005)(8936002)(71200400001)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG1TZGhUbGFNalRsS2VwZ0JRQnF5ZFFXZnpFVmJZckRmeUhFZVczbjhjb2Yx?=
 =?utf-8?B?alVFZVR0RnFlMWUyZ3JDK1dCdm9vc01qTXpiM1V2NEpvU1NQRHpZbEVmRS8w?=
 =?utf-8?B?MUs4OVA0RUhVaC9oRlozSk9WbG9VOC8zK2liWWxHdmNENS85UW1HS0FFeVlC?=
 =?utf-8?B?UVVnWXcvNTExSmRUejQzK2YxcHZ1WE5SZEpYRTN0RzNycVhsbEV5WGtMTnRi?=
 =?utf-8?B?Z3F3TmJtaHA0dkJhSFgxNUFONmpNVEZ1T1pBc3p2b05LaDJLbFFCSUpQa1pX?=
 =?utf-8?B?MVRHWjAyOWlKTVdnQ0NkMENEM1l4ZUoxZk9tM0VETERHdUgwV3VNOTBUdldi?=
 =?utf-8?B?R1JCeU4ySXYyYng0MWxxbUdOQUlGVU16QnV0Y1dqYWV4MW40OHVWYkhLNGdm?=
 =?utf-8?B?Z0pySU9UZEc1VXJpRG1sYlJMMVlHNnZMVjYrKzE4dFJPOEF2cTRMa0tWQlo4?=
 =?utf-8?B?aWgySTc5enZWNGRBYU41UXJZTE5YS3g1eU5mYWFXT2o1cWl3Vnl5YUgrWE54?=
 =?utf-8?B?d2NxMUg5a290ODZ1ci9tU2xGbHdxTEdVKzN5YnZidlBVK2lrSnNXTHRWbUdJ?=
 =?utf-8?B?eFNkY2Jud096UjJma2JydXo4RjkzZEEwWjREbGF5a2ZnTVVIR2xnYUkxbUJO?=
 =?utf-8?B?Y3R1VWd6RS81d0RFcjFrY0xBdUk2YXdhSG1BZmV5Q0x0dm5NdnkrOW9YNDl2?=
 =?utf-8?B?cjNxTklvdDB1YS9MWk5qNkNxSU5vQWFnL3QvZGNYWmxlbklSb28vTDV3UElN?=
 =?utf-8?B?eTk1RUE4aFVzR2R6UEpVWFM4NWluTGVHdmhCUlJMcEJJZ2g4UU1aakU1Wjht?=
 =?utf-8?B?WGd6OFRvYy9HR1pLOXFzdzZYYU5PSXhmekxuaDVLSHZoUHpudHJvZElHYUFx?=
 =?utf-8?B?VFdhbGtUc1hlNld2a1dOOEdWbFJxZm9PaTJzQVlHT2drY05CWHFxUzdObm5v?=
 =?utf-8?B?aXAwODBpUUYzbXhHZ2Z3Zzdid2pPYnNObERLZW93ZC9LQ3ZTWDJnMXhlbG9P?=
 =?utf-8?B?ZWdTM1FsVnRhclhpaVhBY3hVSnBqdUdNSGlYb2tLNy9aRHg4bytQTzI5aktD?=
 =?utf-8?B?SDkzWjhNaWF2blhqUFFhMko4dS9iQUcrZ2hBRmVFdCtUbGdKdGJzYXNWUWdr?=
 =?utf-8?B?Qk9Ydm00eDdkRFhnMEp2bnZoMTRCVWgrYVcwa0xpVGFQem5jSDVlVWo3dUxM?=
 =?utf-8?B?VzhNbVFNV3JET1VjZXdyZkw1Vnk3czBqclBkWFZiSGZZdExuMm0zOEZEQVdi?=
 =?utf-8?B?SXlBUTRZRVlYbUtJc0FJQllmYWErMHhNNkhFZ0VlWWpTVlRlRFFSZzc3OXBh?=
 =?utf-8?B?ZkVTU2NCQm42S0xvWlBXa2p5YkJWZ05VSHBkZnh5aWY5ZWdEOC80N3M4WTMy?=
 =?utf-8?B?bmpzTjM3a1h4b0NnZ3MzMERkbjFrcG5XeXpVYkpkT2NZRDJCYWtOMEhxam1k?=
 =?utf-8?B?am42RUZrTGROa2NGQmYxbFZPNXV6Mmg3dWFUT2NmNVBsVElvZkpXN21wTjVE?=
 =?utf-8?B?UUxCMmdZWE9OVmtZc25vSTJleWovaERYbGMwWVFHNzZhL2Nsd2FLWEJmYXpW?=
 =?utf-8?B?U2sxaW9lVmxBU3RudkVidEZieE4rc01xVy9wc3RyVmsvNW1vaWZrdWVCNjVL?=
 =?utf-8?B?T3hmL3FIa1VHNWdkb3JZY2J4a0dwWGx6VXE3QTdSVWtoZ2wvNU5YK0VRM3JL?=
 =?utf-8?B?Unloa2Z2dWZ3VVBGV1ZRdlVmT0R4K0w5N1ZWd0hQY3R1aE5NZC9tdkRibEVL?=
 =?utf-8?B?RjlwUTFsZEVLOXhzLytQVzgxQnBTelg0b3Nyc1NNbDFDZ3cvTmhGbk5MWm41?=
 =?utf-8?B?UDZGMU9xOWhuTVlVdm5zWFBNZzA1UUh2ZFFwWXY5UURkNUdHWCsvWlNic1Ji?=
 =?utf-8?B?Y1BqUDRBYTg3RXFRcUI5N1o4R3czMGdNWUxNYjVaUTFBTU4vVEk2aUVvenRF?=
 =?utf-8?B?WVNUZ3l3V3J6QnRQaTZ3Yms4NjBCOGVQYkdUbUlhOVNpSUlhcVZZVXpKNkE4?=
 =?utf-8?B?WHZwaDJWYktFaUNMc3hBczFUOVRRSlRtelJuNzAvaXRGU1EwOG0xSVFyOHJo?=
 =?utf-8?B?aHlqcGgyc1lVZ1o2QkswZTJpZm5Pd0x4NWIrb0hzdmZxZDFOT3NNUEFpa1Zh?=
 =?utf-8?B?ZWVBRkl6KzlOS3daOEF2UmtWaUtBVU1pajRjdzZDYnNiQWs0YmFDbXpqeEJ2?=
 =?utf-8?B?UHJHMjg4dll1QVRMbS9VRmRLaWU2akRJbWV2eDI4NFZTb2NqVDZYZ2ZKejBI?=
 =?utf-8?B?eHg5VmI1MGhhSGJ1ZWJwZk9USE5XdFEwaHM3MXNRbVBzb3RkZi9Ldit2d2tm?=
 =?utf-8?B?dThOdERmRjZ6QWttR2NScDYrNElJcFZZYktPc3VWSE9CaWN0QjhodURtSTRi?=
 =?utf-8?Q?YNp3MiiBRGbfmxaw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C79491473ADF214BB728C32AF7B2185A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77420ac3-406b-402b-a328-08da1b946411
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:22:17.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8WCjpTh1fgQKma7ELMizNEHO0Ckcdi62yCpMBFs6OkoRNwRQbCp5hyTm9eFo2yFTfd92fXieveGyYyaejyQ0XDZ33mvcucoQMKf93SSBPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1415
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMDguMDQuMjAyMiAxODoyOSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIGFycmF5IGF0bWVsX3RjYl9kaXZp
c29ycyBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgdXNlZCBvdXRzaWRlIG9mIHRoZQ0KPiBkcml2ZXIs
IHNvIG1ha2UgaXQgc3RhdGljLg0KPiANCj4gVGhpcyBmaXhlcyBhIHNwYXJzZSB3YXJuaW5nOg0K
PiANCj4gICAgICAgICBkcml2ZXJzL3B3bS9wd20tYXRtZWwtdGNiLmM6NjQ6MTA6IHdhcm5pbmc6
IHN5bWJvbCAnYXRtZWxfdGNiX2Rpdmlzb3JzJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQg
YmUgc3RhdGljPw0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVh
IDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3B3
bS9wd20tYXRtZWwtdGNiLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRt
ZWwtdGNiLmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtdGNiLmMNCj4gaW5kZXggMzZmN2VhMzgx
ODM4Li45ODY5ZDNlYjgzNTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC10
Y2IuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtdGNiLmMNCj4gQEAgLTYxLDcgKzYx
LDcgQEAgc3RydWN0IGF0bWVsX3RjYl9wd21fY2hpcCB7DQo+ICAgICAgICAgc3RydWN0IGF0bWVs
X3RjYl9jaGFubmVsIGJrdXA7DQo+ICB9Ow0KPiANCj4gLWNvbnN0IHU4IGF0bWVsX3RjYl9kaXZp
c29yc1tdID0geyAyLCA4LCAzMiwgMTI4LCAwLCB9Ow0KPiArc3RhdGljIGNvbnN0IHU4IGF0bWVs
X3RjYl9kaXZpc29yc1tdID0geyAyLCA4LCAzMiwgMTI4LCAwLCB9Ow0KPiANCj4gIHN0YXRpYyBp
bmxpbmUgc3RydWN0IGF0bWVsX3RjYl9wd21fY2hpcCAqdG9fdGNiX2NoaXAoc3RydWN0IHB3bV9j
aGlwICpjaGlwKQ0KPiAgew0KPiANCj4gYmFzZS1jb21taXQ6IDMxMjMxMDkyODQxNzZiMTUzMjg3
NDU5MWY3YzgxZjM4MzdiYmRjMTcNCj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
