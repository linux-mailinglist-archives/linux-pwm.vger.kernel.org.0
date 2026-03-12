Return-Path: <linux-pwm+bounces-8238-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLRMHOAlsmnlIwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8238-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2026 03:33:04 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B77A26C425
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2026 03:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 237923028B0C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2026 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01037CD54;
	Thu, 12 Mar 2026 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K5KEoCeo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2E37CD4D;
	Thu, 12 Mar 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282774; cv=fail; b=qt0UERkWy+aDrRXMcOPDWx/LMTXSwbgh36mI0kIe5JR9KOnq3DbN0iE2hYhH5GruGLu3RZoyJj/REihv5Xvy1dAP7tyP5WmBp0WKmFafMNW5/X58zN8pimv2F0IihdvcTbx1AdpTGomrXUeVZyWtKzztArEXXM/yRoOBjw+R2Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282774; c=relaxed/simple;
	bh=ZM5PHvRkQ6qVS4RAdGM2F8nctys5CKuXYYcApCToCOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rUEhSLjX+tEtYVqMDCpYRyAx8IHonKWtim5dQyk3XXJ804elRDROvCYXQI+AxEnfsfcl30bVf50nXLMvgI8n/G38vVMMGlNlg+oJYab+w+NzjR+81eiWj4+xe1+vhehxu2yOHP7uQn4CwHilV1fvfQmCOENpCKxLy1iLDL1XibQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K5KEoCeo; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMPC8a442687;
	Wed, 11 Mar 2026 22:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8i/jW
	1NMOhZBVecsvH9yUQq+YcunStdooRxG+6dEwOE=; b=K5KEoCeosizEevXVtE3OU
	KxM7MJvETg2fqfuiSA1jCk8/vcpNwyVOfzrA+g+J+8xcji0y43CWg63JyYk4FAuR
	Znh7wCvCln2apQqhUwGlXZBgVyYo026HOCCTmfH90BR3A1Ddjarrj9aXUT6qG+4/
	qiWp85ZAkT7IyvK2Z1ZCS4tJ/VwhRIDrbr3cvyUT9OtMA+mQ9BGNPB/Qr+h3tlVk
	GV6+WQXIIQ2AU5WQ17VSz+H5YANzt/EtmfzQ615WI4NXY6Yx9VjSiCUUSx3nUIL6
	8cVL8OkgkPsliAzZEjOZu9B6K/ekpbbkzDYTYFGao3YZZHjet3/cy0kPmPNraGOe
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh5qgn3v-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 22:32:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN2gpPrTG9/xluJcSO58m0M3sgz2GmvFApWDgW0C4DO/0r517dNhBYG+P6T4iZSNl2p3+03/1SGBFgRtrQ5VOc7qkiVhN6o+axaIYyfwt2OEkj182e7T+NqR+2nWKzps7ZRDWZdHYSoD218uuCRgF7TLJv1Y4PUtUNRcoXRKwWLhuFAkmvuUTzmiE7Ews8n6sgMgdlZO28lEiLt2sJSM07cNRnB68Wnc8wnvsbbS/oq8EBFyrohb1M4f4DnZmzCuzznhKY9X9ehT/IAl8Nhdj5pLeqyZjXxm1WWjP/cthF2ugz+Woppnlx16HWGQiv6rZ44loiJOxfeDB8JXgKgVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/jW1NMOhZBVecsvH9yUQq+YcunStdooRxG+6dEwOE=;
 b=PYoSwUjLVwxsRczERI5EmED665uYkOvX9s9UCrIZ5RkB2Anr51Xj8l+UdqDhhO03ZeIGkO4IyOXeTVe/mJkU1EporM83odD48NgWJVY7VoIeMa/+L5UsDYiMj23YSjHP1qviHVIr7/SsDetyoITOJzEAbdDLmLNFGtWEFVJrUIyKhEQ4E13oM3KUAJbMPoCKTe7bs7weQUY9MKxmJiEr8LjG/YRaZ42KXJtFEmqMuhLcoZ0QnZHl7qt1a7CldeI1fkQFiYQotHB6x7vUo1AqLi4hA58p/zKyOFLawk9uy9lirZFeE1yzmyaO3fRzObMkxbqxHAMRFlWABaZhbydxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by BN8PR03MB5058.namprd03.prod.outlook.com (2603:10b6:408:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 02:32:22 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 02:32:21 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v2 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcsO1cvIZcATiC9kK4qKSLqBMDm7WpNvSAgADzu1A=
Date: Thu, 12 Mar 2026 02:32:21 +0000
Message-ID:
 <PH0PR03MB63519615ACE22ADE4055D2DBF144A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
 <20260311-dev_ad5706r-v2-2-f367063dbd1b@analog.com>
 <abFVl8NhfBkvyI4I@ashevche-desk.local>
In-Reply-To: <abFVl8NhfBkvyI4I@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|BN8PR03MB5058:EE_
x-ms-office365-filtering-correlation-id: 74d94d2f-313c-4540-c24f-08de7fdf96c7
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 e2zvyrzopuU/7KbCTPFti+c4QrM1Zc0KWUGRscG197mT4DgHJLtgusmyv8HzhXYhTBtx8iH9uxjgVwMSk8h0JmL+zO6et8gsUrtFMFzijpOUvl+w2vIP2RrJbDl7YNU+kgC7IZQBSQ2WBcGOfDYugR3k0Vkm8E85UmdePUXn/3u/rHAXjZmxe554Js8fHlRfNTKJSk3qafdIYjMNsovlABjNJ1+A+V4eW5XiQCq+RYvdZIdo8CIGHPcVRoEO8Qg/lU6cKl0/MlyRe0Vrny7KeFhFT2JlhI44nRzpQJlIHm1QbzwhHmYcOWdEiNP7rWzOEgUxI2hS1LpJ399av98q0oRSfzZPbg6HTymO2gsJlVr2Wd/LRvO9x9hXbBlGGmOLgKvcL5TuuPJoAm0paW+/ELUdvNl2k3u6miU1HPhEVw2dqDQg+L/seumNFn1pCFfwkoaCKq2yyhz1gh6zOxf+s0jMW+bxHJHspGSL9MYOHpT14LWcfjbg0u+t+KypaNhyEV5uElIna3HOVJp1Da1DeUQW9AdpG18IvSXhino+1bKU4vML9FViFgkgflR164mdbmjepp7N5a9hfJa+tI/iSfjuPaBx2FftjtLHlJf7I7PJe0Qmb8Xx8OQIsmSJwtDrxf31nof4ZIPYmxibhkWPOQ6GCEHjIAL7NJEzc5z5t5qN/KdPmirHsEWukL6m10hOzNPxgkgvdIpUFuFBiV04o1dZPIGLYYlP/sHooHqRrEy50S9BiZJEsM5+JGOh/zlbe1TInQ7jqW/+AwfOMmRkcM2cSoWf69s/3A0ablijS5E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HR/+zfc5rBT2wXi0B5Q3qdUMlIZFhdIu+DPeBvgsm1Wd1ttwJZKG1PH/cI?=
 =?iso-8859-1?Q?Ou1qgiXrGzP9kygaiSHv87ZGM/njgBJEVliBKzanvRxarjKIXcrY7hi8cr?=
 =?iso-8859-1?Q?0CZdLzMeO5OtLhdq9ba7DQXHOFX2HU21ILn9/KEAf+SbKnIeOgJ6FcfE9D?=
 =?iso-8859-1?Q?Pw8BULRL6CZbslkfCxg8+T/rH9nWOxjvFFLMnf+DmJzftCCBkPzovdF28Y?=
 =?iso-8859-1?Q?Izk5n+4Sl7wtwbTf7kWmc6fAQdwYrUo88UKUxFZkDwsog97eCGw15AbIRm?=
 =?iso-8859-1?Q?P3Fr2W1Vk6SHh0lBN7WQOj478X7yk12zpx/UzOt6UmlZZocsMuXaiHuU4E?=
 =?iso-8859-1?Q?jgfM8GoAP8EX2dt7cwyzzyeZvEgCNIhZlBjq8xxfI+LCU2yEUB2tXFkTT3?=
 =?iso-8859-1?Q?jKhHTw2FlDdvt6VrTrzktNiGYsOVq9VOwoFXxmJXyek7XVsKvQVj46nrCM?=
 =?iso-8859-1?Q?POqkOmlJ00y4TNy1CoEvNY4mIGJlLwpkt80mJxc8Xs0CUVqGjjpffljG9A?=
 =?iso-8859-1?Q?mqbmcjQUtPpfB0+2DyCfdddgblHnkaY/eUFi1i09DOmWhQlJ6Bgq2elneC?=
 =?iso-8859-1?Q?H4MwYSsLk7YWuIM5WnKYWGE0E72V7pIQWQ+bMKpYDlr9ephySS5H6cEaGt?=
 =?iso-8859-1?Q?lieNhGQXZu4o1cNGT8urD97mHvCUbPQTQDqGg++Bwe6hn/zgOXJLe9lNpG?=
 =?iso-8859-1?Q?AIe1hYsS9i4N4dy3gJUnSUjFaZYPQ/iRd+Un2A7JL9lwsJyQ1Re3JZvE2G?=
 =?iso-8859-1?Q?ZQ0pbrx7ZRYDdi0wN4/bcsSmNIj9vEzSA5LX1iPJaXV0EckhOiX1fjWcA4?=
 =?iso-8859-1?Q?ePUkmBWwP/zQgl+cR0eFEAT/2YkNOzxTAA68eHSkD5Nh7H9eocyDPjW1dn?=
 =?iso-8859-1?Q?uBI3FPunhzdzkjv4W+IPyhnEWLOK5VauzHETULcrU6Z6bwLXw+C3d7CXoj?=
 =?iso-8859-1?Q?k4ItAdQ5BzIKl4iitZUd2rQoPDH5XL/e/wCulNfRstWmSBlo6YCo01xekl?=
 =?iso-8859-1?Q?2iZwiXEnaAxw7dBitPM/Ms1mOowe7spjO0zQndBSM8tx3itJbgUGn9QIpY?=
 =?iso-8859-1?Q?/Z4BsO/hCnQJMu0R04VMqzyVa5wyBZiVUn572+QQDxsJz7DIk4KzaPn1f4?=
 =?iso-8859-1?Q?SYv1w/1E2K0GIoW84RrLmseEYp1Q17dOOWApjs/JBi5pvUqYgAqsCFPsWj?=
 =?iso-8859-1?Q?Kwd4KWzJrGsDxkXsdoF+fTTwusvJIXr6vilaP7BUjBNWY215ZCIhumSaT/?=
 =?iso-8859-1?Q?Zrh5b8hVxbWXzjCpZ+q0jkrbuSfRe1jXXBK9kdl5M/MPLlAC2ofrB+S3XV?=
 =?iso-8859-1?Q?5SnxwaE2vg1nkQjBT5FpJQSXCcRBcveYTWRW20YhoVZdwXXnDu+Q7N1E8l?=
 =?iso-8859-1?Q?G1NdRMTVDD7CdZtNN4SN8TELBdG1UJbyhInD23SPjnCubIXEZZlUVVkI5u?=
 =?iso-8859-1?Q?JDlTO4ZMV0msseuV0ndm2iiVoKJGfYBtu2XSEBPlnVafK7tfrEnDzMmjXT?=
 =?iso-8859-1?Q?VNROe+RqrccGJTwil+Mlh/NSxHp+F9eLnS8bVSjhtHKolV1MzZOvJnHMEt?=
 =?iso-8859-1?Q?1+XPWDxka9SI9CjItDYJtpT6gbCJ5J3TnVueTPX4+qGb08u50mRmbtB4uo?=
 =?iso-8859-1?Q?at0YC7OaogOdiK6wmrYy9i/aJVOmyBuXX26X+Lmnw2fIvYX/jwhhSJwUTv?=
 =?iso-8859-1?Q?mgCcHuMqT1QmChbWcGvo88gndRe5MsNaoG3a4j61IJ980jetfBE+AT+FDz?=
 =?iso-8859-1?Q?DzUq0oU//0lDJ02CXEreOrTr+70up5eC0EZDrGliwsNPeT8RfGKs6FlcNM?=
 =?iso-8859-1?Q?sEpjwSXs2h58VyzVJRzX9bcaWwiuA/s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	u+Uhy59NA3GJSG3dbI5B2Dz9TeK03ecMGVPz/lb+CATY73qc8ZBxlBnzvzZoqQvvPe0OmC8L2cATVn+1sBO/coG37jJGCYe30jaM5xHEMPuo7CyeLRP6SJvShwK7Cx8wP/EPel2ypowSHXsSmg4nW/3q2MYax7XQ9H0FwBDI9FqzJT6wkhajHMA3xFLk3HFQkaWhy0yqbtRDjggyR7WXSy+tFByxQJzv+sPCNDoXrxo3K1+uiD75YAXhsHibz30RjcbR7iJrQvtNIVjXUFzONbW0lV1fpZLPgg3q+e3rQR+kedtaYkW0hINOmCR4pE/gJxb4YTI59Mjo+wY/DCu/Cw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d94d2f-313c-4540-c24f-08de7fdf96c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:32:21.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xe0d5ZkxLeDd3CEtQnUPwfd+HeS3AoeQQqjNMYNX86/SZO5U6hFUpsxbshTT14uQRFNbJIe96O98k44i9tLh4b6gkn60rwyODYD68i7rv5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAxOCBTYWx0ZWRfXwIQw0IYmffwV
 jqNBsrQYtjzi08ZXkB343b8GwYOcS3WrUKA66/DpPaCPFU9SQDVTHfgKIRzLCGBLDciQyVrE+Yq
 cN/j1ThKRT+q9VK6HAJ8XnKwPgAIU5OqSuiVr0lHM17/NPARPo++VBzfnsMMKvsTrOOcxv4/ERe
 jgyZp3NLbzdD3XMA2N73lfyC6sbJWiIRT2sBKm9DoveuLkmmXljIbOQEDrU6gmXde6KRWq5Uc8T
 WlTatTG7B7xOzInVgiPCe6/cA2Fm2FCWO/5x0u0Ut5SYNm2QokCCBp4BLbQX9c5OCzz9u1HHj7s
 jAWUf+dS7Ej+5DOfh0MJWXY6Jas20Qohqg2atqHUd5YxX+gsnbG2fIcJb4p+YFZWG7E+N/Vtrie
 13HrKnM28xolhKBb/vB8Mo7fnRphf81jUEPeSCkDBYdNTC5hzL1B/HXLa0blRk43h6tb0692WP8
 CsHAyCVdCGP5/Y7op/w==
X-Proofpoint-GUID: kB1PsQ98Xsbq2GzNK9gb8ZSCSEqKutM0
X-Proofpoint-ORIG-GUID: kB1PsQ98Xsbq2GzNK9gb8ZSCSEqKutM0
X-Authority-Analysis: v=2.4 cv=N7Ek1m9B c=1 sm=1 tr=0 ts=69b225b9 cx=c_pps
 a=+4AL93Ollhzyglb1kYk7Zw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=KDJ5RcydbglllALAYUgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120018
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8238-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,PH0PR03MB6351.namprd03.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[AlexisCzezar.Torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B77A26C425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> ...
>=20
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
>=20
> IWYU, please.
> Yet another typical issue with ADI patches. Really, talk to your senior c=
olleagues
> who are experienced kernel developers before sending it to ML.
>=20

I'll bring this up. As per your suggestion in the other mail, compiling com=
mon issues
like this may be needed. Lessens pitfalls for newer devs.

> ...
>=20
> > +#define AD5706R_DAC_RESOLUTION		16
> > +#define AD5706R_DAC_MAX_CODE
> 	BIT(AD5706R_DAC_RESOLUTION)  /* 65536 */
>=20
> Useless comment, use the same number explicitly instead
>=20
> 	BIT(16)
>=20
> which is much more readable.
>=20
> ...
>=20
> > +	st->tx_buf =3D cpu_to_be32((((u32)reg) << 16) |
> > +			((u32)val << (16 - (num_bytes * 8))));
>=20
> What the heck is this?

I'll make this more readable.
but the format goal is:

if num_bytes =3D 1
    tx_buf [31:0] =3D [reg 31:16] [val 15:8] [ XXXX]
if num_bytes =3D 2
    tx_buf [31:0] =3D [reg 31:16] [      val 15:0        ]

>=20
> ...
>=20
> > +static const struct of_device_id ad5706r_of_match[] =3D {
> > +	{ .compatible =3D "adi,ad5706r" },
> > +	{ },
>=20
> Even inside a single file this is inconsistent, besides being third of
> 101 IIO	patch issues.

Will note the other feedback and track the common issues.
Thank you,

