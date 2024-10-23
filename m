Return-Path: <linux-pwm+bounces-3772-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE19ACA11
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC001F21F2D
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746DB1ABED9;
	Wed, 23 Oct 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="gCmNGBTd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022079.outbound.protection.outlook.com [40.107.149.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BA1ABEC6;
	Wed, 23 Oct 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686838; cv=fail; b=Wk+kJONuX7pSCstr9su2H5AhjCsJVMpTvBW4ggCAwYxZxBL9FKbOCf0/lpdTgChISkFVCylRwkdFxMohg1nHvcdxKNDoZu08/s9wP+YMJYXuBJkS8sLDHkPvTc9P4JNoy9dOOI4bO35tYPqprJxGLqQWLr0Nqb4VLw9zekmSbYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686838; c=relaxed/simple;
	bh=nRfuZNlLhk+ejQWglmt4jBd6KMoGgizwF8AwN9bp6h8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K/TX304FUGEobTeB/YIpwH4/EZ9s/+uoPtQPiyDEFne02PS9ggRacrddNOgbB2c1KTGu2dK+6dAHG0QevDzRBKu7YzaJdzAKS5frM2t+r4iAU3Vb5I7KNKMKnjhhYKFley08XDpODj5uFRJQaJ7Ih1ORt/2VWytJ8vIMZnWKQjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=gCmNGBTd; arc=fail smtp.client-ip=40.107.149.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxQ5AWMc6DB/xSRugdepYrcARAsQMtFe+iM0zrtKKshZA7kcSqn4CDCyejh1rk8OCOJfq+PZNw5mv6ojSxFF379930Q40im0zGO6y34mtj/7OKTGi7q3C5JvVhBoFBsTnpu8r0oVtCJeGv6RlYqkDx3uo4VybPVyQRlpWLZnfRPHt8D+41dAacYUAHrjllFgsabrifDD7RYslwikqw05cxEkPcce3tEjtLZXOu4Pw2yWtTU54ht4gtojBIvjzhSc8+fIBIGWN4pT/pW142NOZ6UoFZjFUom6hjbVSZdhUtOMC7+HU6gfdXnXRTAIe3SfPF7arGyrYyBDc4CD/hD/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRfuZNlLhk+ejQWglmt4jBd6KMoGgizwF8AwN9bp6h8=;
 b=EP4WdMJrGYDcarMSintiT/OwT59YOBHToMrxjswqrbmnipHeajOY4R9VxPdM7W1hQ3+GS+/Q5YF1lVqlxNv2aCN+1JlQRfcBQthWOfT441dXLxFPB3nwelnin/srbyFSkiJy+2qfQFkAYuBHPWNIZXmQoI/TFiVPcxgiNa4nFODYNx25kEFlVNOj//mp+yaoiS2HSAAU14FvL6TDcbNOZ9zOy815IvF2Wo48NnV2YO74xi//nX9n3X2EgisUIafA6tQYjDQm6EKX267lT8e8yYTwhc2ApA/LdVyBWVPehmkoVOiszz37rOLrB4V65mgGoc9kjMSSwqinI18IEJs2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRfuZNlLhk+ejQWglmt4jBd6KMoGgizwF8AwN9bp6h8=;
 b=gCmNGBTdwfkArIunyhgN6rHX4AQ/u8dHK8LZVEfxV8a7gODIfc3SWdyaZWugjC86iNrBSTYPdc2HQVdUL6+aPO/+q5aPVHwziU/CZ+Ue/rWos6q/IB+U+5DGNUnnfaWhMSXXVVsq1c8I00lOBN9Ap7G1RrKQQ6cDULDmPCiCYDRg9QmW5ULdB5h8qGz17QJwRmNF7x5+K6CQTd346OgODpNJD++yoWyyyX7dqS2BgVzntns/usSbSxTjXihz8zb4GLDVTePhhoEQQnLcL3A40ra5FVP0fT4UoBhEOVI//D1M4d6eqasksEkY3NonFIB40juhslrplm4MPXw9IRpC2Q==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FRYP281MB3257.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:72::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 12:33:53 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 12:33:53 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "ukleinek@kernel.org" <ukleinek@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: [PATCH] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Topic: [PATCH] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Index: AQHbJUfRxNwwaOjAIEiewaTXGCuTjQ==
Date: Wed, 23 Oct 2024 12:33:53 +0000
Message-ID: <349a25ddce02d55cf5a321f27133cae1f34f1962.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FRYP281MB3257:EE_
x-ms-office365-filtering-correlation-id: 2871d0c9-6c76-489a-3679-08dcf35ef46b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWxzTFBDU2V5UE9GdVZQakJRNXp4bEk4Nld4SnVHUDZydDA3S2Q4YXpwcjRt?=
 =?utf-8?B?aHRIWnlsZ2U5YU8zeUliWHd0a3ZURFRwakdmM0JCTFlaMzViclV3dDkvN0lW?=
 =?utf-8?B?NVBpcXVhR3lKMEsxOWMyVmlUVTNxQUM3bzB4QUdHRzhVMllsQ0RIM1NNZnB5?=
 =?utf-8?B?bFYxWjlPMG9BRTMwQURmNkZWd2o2WUx2cVRXMFYzSGRjZE5ML0szdm5RR2sx?=
 =?utf-8?B?Yi9EeWlaTkNGK1ZGZVpzcFp4NGt2RG5GUzdlckhPL3lwWHI5RFo1a1BqTXV1?=
 =?utf-8?B?MzJ2eTRuNDlsd2JCNlB1S29ySndyQkxVZWtMS3NIWkoxYzFQRGY2ZGlvNzBG?=
 =?utf-8?B?QTlQUW5vMjJETXRENG1TMFhQd2xMZ2lOWGNkVktibVliKy85bVZUaHRKM21o?=
 =?utf-8?B?Z0VINFFRWHpoQ2RTLytiZTBoeGhIWUVSNGtCTXA1TkN2Z1YzSXA4ZldyVmJj?=
 =?utf-8?B?R3JPT1EyMWJqUGp2RWZGNE5ka3YxTHlGVUhvM0dsTU9aQlgxam1ia01lY21R?=
 =?utf-8?B?S2VnUmdLVk1CaVlWN2lQMm1CRFN6aVJwSUFOWW5pZDdqMVhPVnF3bnRYYWxG?=
 =?utf-8?B?TVVDZ1orMDJNeG1oQnhTTWdEelpTQlNRblB1dzc2S3lDSE1uVytOY2NEZTZt?=
 =?utf-8?B?OWhTOE1aMjlUR2EzQ3hweXp4SFFad3Z0WUxXYTJOZ0VIenJ4b0FhNGlSVnhn?=
 =?utf-8?B?bUZweTI1a0Jjb3hVWU4vTzFoeVdaSE9oOE1ycnFQNXhMa3hzeklOalBqYm1s?=
 =?utf-8?B?cDlkWElSd0dTaDNMVUx0OFNpb1hLVFRUSzByZTRtTGlqNHlBZlZtN0Y4MW1s?=
 =?utf-8?B?eXpMeGRhbTAzTEYyY1Bzbi9LcEV0QytEKzgzYnN4V1ZVM1NqZStEU1BFYTlv?=
 =?utf-8?B?Z3BmQzZ2YVVyTnRPTDJtbVJGeENYRW53Sk1SZHJxUUhyZTNCR0xBd05nSTNa?=
 =?utf-8?B?MXRsZ01CQzNQbFFFSjNvcE5XRjJRcC9BZEJVWTZIWVNVU0xyL3B0MFpBc2oz?=
 =?utf-8?B?YkExNHNnOXgvVnpEdFRsdnA3TFB2TGVLd1FrczdObE9BR1hUMjUyQW8rdDI0?=
 =?utf-8?B?aUVWNGdBN04zSmM4cGRaNHR4OFZqcEJjRjNDODNwVkZTWk5Ub2t3b3RwbVhz?=
 =?utf-8?B?VEJ4TUZWc3VqRHV0NmY4VmN4ZDlzcVdpUmhkRnpVSWphbENnWEIzNjdKTDJv?=
 =?utf-8?B?cTlQcjFTY2g0N3cyZ0hPSjlrWFVrYzNPc1JieTduREtRYjdHazFZN2NpRGxK?=
 =?utf-8?B?b3BoVFJJdkJ5bnpnZjB4K2d4MWFMM1ZRSGg2OWFQcVdIUDRmdUNKaU9JV1Zn?=
 =?utf-8?B?bC9Cd1BSVUhtSDMyd1EwOHVJb0lpQzVsSFJNUHdHc0p1eTYxdEFVbWZieURa?=
 =?utf-8?B?Y0VMWjExZU92VnF0bFh6eXZ3RUpuQnhYaVpyaTdEKzBDUkdMTmdJTHJwdHdu?=
 =?utf-8?B?R21jZHNjbThQejdGN1BmczlpSitDa2ZIWk5pd0JsL1pSY2x0d0czV2FhTzR0?=
 =?utf-8?B?S0dqZEYxUnliczFFSE9WY0ZqUTlxeVQrVml6Z3BEdnUybHpLVFVDYW90WlEy?=
 =?utf-8?B?Mkoxb1VVeHU3T09QSGpEMVpnQ0lCdTI3UzdqUHU2UE50WFZSSDlSV3JSYzhX?=
 =?utf-8?B?NFBPb2lGU3lleXFWdnBlUnk0TzE3WHA1SVZWSDhHRmNwcVIzeXJKS0RHZUx1?=
 =?utf-8?B?emY0enhHMEVDb0VkSHhqQ2g3bzZ6bkpmSklNMmIvbmE0VjRSbUx1cVc0SkVP?=
 =?utf-8?B?MlpSVXYxNHNud1JtS3RiUzRrSHdUeUQ4VmVYbE5iak9mUEJ3UUFVSi9sd3hU?=
 =?utf-8?Q?ogytNZUoPuLAj7pU6yThJwxc/yh6KRFCZ3pLs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWVrYVpyenB5blA1VmRDcVMwaDlHTDZvOURGMFFhcGV6ejJVeU84UHFydVdz?=
 =?utf-8?B?SHVTTWdrMVFhanB5L0xXMGE0SlVzSUY3L0w1WWZuY05PMHAyU0tlK2hodkJw?=
 =?utf-8?B?cjFuSzVDRWZjK0Z0WU0yVDFCSzZaQjR1WFZYUDlWakd4UDRvNWx6L2ZwMG5n?=
 =?utf-8?B?VHhtcXMwYnMyakF0T1NvZFJHUFBLYlVqdFpiN01pLzNZcFFmUXhtRDFkTndm?=
 =?utf-8?B?MTFtTnM0dnUyVTk5TGZjTWpnWVlGZGJEemdLa25PTzFLWDdZVkE4ai92cmtQ?=
 =?utf-8?B?NGV1aVlHKysrNzVaU29hSUpKMWxhOFdrdjE4SEZQVkhPN0wyVDRPcjFKVzh0?=
 =?utf-8?B?aXNDMWZpdk9zNHg2WGluaVFwT1RGVDBlS3FHS2M3Z1BVYlB3RzBtNlRTWjN2?=
 =?utf-8?B?QkR2YWxyMGVUdzVydmF6OGlxVng1SnBRTjJ4ZlM2eU1Wc0x4N0RrclhtRnd0?=
 =?utf-8?B?MUdBVUdQMGQ5VEF6d0V5dlZWbkljWitvaTBWTlgvcjNrTUhwR0FCRnd2c2dP?=
 =?utf-8?B?WlJxM08xemZuNFBTdC9wcklBaHZ4ZkFUalhRUFF0d0hBZ2t0dnBLaWFuQk1n?=
 =?utf-8?B?ZUlPRmp4UTRjdng5TDM3M3QzOThVKzhFWC90RFdBbmx1L2ZNYmRkNmZQM3ZW?=
 =?utf-8?B?WWxuTUhrMzAxeHhKbDdGckh0aFZVd0NSL3V0aEpWK3VGVU5VQVZmQ1E4TUFN?=
 =?utf-8?B?SkZUQkE2L1k2Q3dxQkt0K0FMbnVRWllsYS9wUGZ2b0ZvWU84RXlYZEpyMDZn?=
 =?utf-8?B?L3pzMkRBTjI4VUJPOEVIVWI3aVJ6bHRyYWtzNmhmblJBdzFpL25HdjNBdGpv?=
 =?utf-8?B?bEVVQ1hNUVZqbzRyTTcyR3lPUUpkNk13dmxibFVveXNtMmFJbFBqalFSb0t1?=
 =?utf-8?B?QnJaWEljZ0tFOHVjU3ZkdUVwM1g4VmJWYkVHM3I0TnpEK0pmU24zVkl6RC9M?=
 =?utf-8?B?aExLLzBSWmtORytFbFVOSzRKUVFST2NWTFhBNzYyOE5Fang5b2pMTGJLaGFJ?=
 =?utf-8?B?UEdaN2RRSWtVeXJhQWlQVkppU1RJVEsrTkFyVGFMT1htb2JHZDZ5TGVzVmZy?=
 =?utf-8?B?T1Fkenk4dGNsbkJ1bmg2M1pFYmZxMFBBdDlEcVQzcXVFWnV2eUFqMy9zNlVU?=
 =?utf-8?B?MTRUQ3lITE1NZlR0VXFTcWNsT01ZNFFQazVFb0xLSWM4cWVxOWRHdDhxSTB0?=
 =?utf-8?B?SFZtdGhPc0hLK1lEYVhmUExOU2pHby90TEV1bVBOUzd3dkk4dTRVTWJMUngy?=
 =?utf-8?B?U0JnNUYvMS9NbzBsZ0dYQU1DaGlmOS9qL3F1R1AzNnJWcWdKeG5DM0ZXWXE2?=
 =?utf-8?B?TDBZSkhnNmVVWURJR1JuQ3lBUjErY2MzVmMxekFZNzd4QWFDMjcxc0UrWWZQ?=
 =?utf-8?B?UWtIcXlJcHlGcE5NeCtuOWd4S2d3RU5YV05ETlNIdHdSSVV1NDBRQWdRYkFs?=
 =?utf-8?B?akpJaXlabWs0NGF6Sm9DZVNqVmZqZFJxSUcxaU12YkRkeFdmeUw5cUJuOVNJ?=
 =?utf-8?B?NWs1bDBWYkhVUnU0YTBNaDRaS3d4QlArbkxXcEoyNGZJeXY1dEc2bXdvWWdE?=
 =?utf-8?B?dkUwZXBuK0llTk9KaUNpeUZwNVVBb002M0N2WjlJRlI2d2dmWEdPY29GWjJX?=
 =?utf-8?B?RWFLZHNlUFE0aCtLQVJORWkvT2JoQ0o4eFVsc1FCdjE2dDY0Zm1DcDg1SVA1?=
 =?utf-8?B?YlQ5ek1pMkNQeTdtc1pCSG5JN2pmbElTQVlYUWlua1F4cnJvL0d6UUswbFRG?=
 =?utf-8?B?bTdpWlladGc1WUlzYUVzSEpDczB2K2xxaDZmRUN1VzQwVW1Cb3MrSWY0WFhp?=
 =?utf-8?B?aGNpYy9pUkRmS3hEbkJWUlA0U2poQklkTXo0ek9oWk1QMUNGRGl2VHgzRlFl?=
 =?utf-8?B?MWI1YWYvZFAzb2ErREsweGMzRCtodGdJNGVGdXkwU1FMQ0JXaSs2ZnlEQVlG?=
 =?utf-8?B?ZEJLemZ0NUJxa2Vlbmg4NCtXSGNFK1dSOHJzYjZmSUdLckJzTGNTeFNiN05S?=
 =?utf-8?B?bHUwK1QrbSszazFuS3g1aDAwMkpRVE04R1UzZXBSdlpVMUplSVJkNGFSVDFv?=
 =?utf-8?B?SjVHemxUbkxic0EvaWgxQmxndWpHS1hUZUpMcVk5dHJzZEpQU05wQ0V3U09S?=
 =?utf-8?B?TGNZeHFzN05MSEZyWWk5aWE4U1UyMDgvK3BkcXZ3dHpBWUIyeG5XWWc0dEds?=
 =?utf-8?B?aWlaSUlWSWthajBkZ25BYkFwdnUrRlhuNmpsa051TzVXM2p0WDRsMnFLV2Mr?=
 =?utf-8?Q?6m4/Ye3mpRaCX0boh5ru5s8LVzC8afRrIuH7K/yk40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35EA6B3C9D7AAC40AA6DFAD3C6221786@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2871d0c9-6c76-489a-3679-08dcf35ef46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 12:33:53.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luvfW7zyX6HuaBwZ6gacuKy4ExZ1WaGHzWthueouq2DeU1+dZeGxcA5RHs24sVyG7ZBUlVFFzu2pKiQpRI4FQV3hy/JcowUYxchD9cc9Sk7SL0FTY8F9NlVbjsIvd5Eh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3257

VGhlIG1vZHVsbyByZWdpc3RlciBkZWZpbmVzIHRoZSBwZXJpb2Qgb2YgdGhlIGVkZ2UtYWxpZ25l
ZCBQV00gbW9kZQ0KKHdoaWNoIGlzIHRoZSBvbmx5IG1vZGUgaW1wbGVtZW50ZWQpLiBUaGUgcmVm
ZXJlbmNlIG1hbnVhbCBzdGF0ZXM6DQoiVGhlIEVQV00gcGVyaW9kIGlzIGRldGVybWluZWQgYnkg
KE1PRCArIDAwMDFoKSAuLi4iIFNvIHRoZSB2YWx1ZSB0aGF0DQppcyB3cml0dGVuIHRvIHRoZSBN
T0QgcmVnaXN0ZXIgbXVzdCB0aGVyZWZvcmUgYmUgb25lIGxlc3MgdGhhbiB0aGUNCmNhbGN1bGF0
ZWQgcGVyaW9kIGxlbmd0aC4NCkEgY29ycmVjdCBNT0RVTE8gdmFsdWUgaXMgcGFydGljdWxhcmx5
IHJlbGV2YW50IGlmIHRoZSBQV00gaGFzIHRvIG91dHB1dA0KYSBoaWdoIGZyZXF1ZW5jeSBkdWUg
dG8gYSBsb3cgcGVyaW9kIHZhbHVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBFcmlrIFNjaHVtYWNoZXIg
PGVyaWsuc2NodW1hY2hlckBpcmlzLXNlbnNpbmcuY29tPg0KLS0tDQogZHJpdmVycy9wd20vcHdt
LWlteC10cG0uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMgYi9kcml2
ZXJzL3B3bS9wd20taW14LXRwbS5jDQppbmRleCA5NmVhMzQzODU2ZjAuLmEwNWI2NmZmZTIwOCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMNCisrKyBiL2RyaXZlcnMvcHdt
L3B3bS1pbXgtdHBtLmMNCkBAIC0xMDYsNyArMTA2LDcgQEAgc3RhdGljIGludCBwd21faW14X3Rw
bV9yb3VuZF9zdGF0ZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsDQogCXAtPnByZXNjYWxlID0gcHJl
c2NhbGU7DQogDQogCXBlcmlvZF9jb3VudCA9IChjbG9ja191bml0ICsgKCgxIDw8IHByZXNjYWxl
KSA+PiAxKSkgPj4gcHJlc2NhbGU7DQotCXAtPm1vZCA9IHBlcmlvZF9jb3VudDsNCisJcC0+bW9k
ID0gcGVyaW9kX2NvdW50IC0gMTsNCiANCiAJLyogY2FsY3VsYXRlIHJlYWwgcGVyaW9kIEhXIGNh
biBzdXBwb3J0ICovDQogCXRtcCA9ICh1NjQpcGVyaW9kX2NvdW50IDw8IHByZXNjYWxlOw0KLS0g
DQoyLjQ3LjANCg0K

