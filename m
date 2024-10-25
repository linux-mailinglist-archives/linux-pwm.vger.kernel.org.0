Return-Path: <linux-pwm+bounces-3871-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4AE9AFCB6
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AE21F21493
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B441D1E92;
	Fri, 25 Oct 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="PhVKrdm/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020111.outbound.protection.outlook.com [52.101.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDF1BA89B;
	Fri, 25 Oct 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845430; cv=fail; b=daj2ohhOWjyw1hIryk71NVTMS/NRJiOzG9iTJamogmqT8XEahqJqcQQcQgF+e58d+UPOrqyjwtu8pLcTouaM70sPkuweP0b/owYiYgESw1DuHKZsuPIpvzFawtZwvTjLHxb+Q2HBqpVmvPEy0K+layxsruFFqldo0fNZ270KzhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845430; c=relaxed/simple;
	bh=ZSRIT/jeRnIARScqHi2syAgtXNsb5Qp+yMCFhdccpaY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a2yLY594I/G8VUTL1GeyqKLqeT6ok9Btn5HLiXunlcpvvF2/MF7CP7CjhiP+4wfteWlq3S+FaWrQNQwxZl9e5Qv0CQ2zlpVc8cKBFdQGwcQbG3TL/B5YAOYAHlYhYA9LxlYt3qJVZ8nvpcI3ReBIGQiwjjBZqA+YYchCl7PwW6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=PhVKrdm/; arc=fail smtp.client-ip=52.101.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB4/f4C6x2mk0bHgGhLpMLHQ/AbSV5P9MhkjJ17qhyfc6O6lRj8a3ti98gSQK5gimDqw3UXR0slsI1KCSDWCrEPHfjYzceXqVAT6aHdIJk1mAPPhNipQDuuLOB3D9QzHUt0s8BAT6h9+yj6Vi5yROgRU0IPxy5h68OXVkGFJR6UfSnlBXfiW6kITSn4FJV7puDojot/YVK3ouFXRy0PqMuio28+g/ktmRsLPslzoQJh1925FGcpz3MaVQzVw6IlQswdAF+IVu8qe6P5lG+2x+AdlG5U+Krt4xQEf+SmtsY6dYo02MCYnUhrhNDfvtKhyVdtSdsBw3sWTXjPK3IRJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSRIT/jeRnIARScqHi2syAgtXNsb5Qp+yMCFhdccpaY=;
 b=bHZ3sLXVbAI3MGwZJJtxUuXNOI0Es6qdf0hC0abFD59MEV+eX2IjOG/WqBgCM4g0aPTf2na67MW278UnQmUMd2hYygsqX9BZlkzccflKsRjYvVVp0WLXex423walJYcXJxXgt1vtPtwAZqd/rYgi4Rd/pNaxMo6qJSR0qkxz0Se9Vqx9M/xN7J4DQtO86MA4bgmkx5oGhOfZke3QxsOh6QOVVXt2KP7a1h5Ddh8Wg9eicx1djmopgjIM0oasWrBFN+196t8Qdw/ICwIrV5B2j0a16zB23JUGrHC52L+gFhbxxzT7i64kLDmybPXes6MaPEafulszy1Myd0orFkw+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSRIT/jeRnIARScqHi2syAgtXNsb5Qp+yMCFhdccpaY=;
 b=PhVKrdm/uZbYni+sjEfdvCMj6pVltvSG/O7vRuRdS/wcJRXVO2i4EDdzkP7QR+GXRhodlxQ8twIwkq1l/QUFZkS53erGNh+AKMmBCUdD0+k7b9eMKuJqs6CwjzMmhTrF3yUJgsLlNig5nt9snc7ItvEXshQ67ybq9m27afeRbuTwyOfeWbBIVzLTci3sD/tnnEjkAV8E8nHwywjtflg5qxJAIaDEufQWcQOLBfQK/du3ADdubMlLd2jAkFoAm5Ykopl6GhqymPqcFeAKBrEeUNTTm2CEEwAuGShIFMZeXfWmTpKXGF05zU5RvEGgi0ZTX7iK0qM96R6a4SZtL+iThw==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 BEUP281MB3428.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 08:37:00 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:37:00 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "ukleinek@kernel.org" <ukleinek@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: [PATCH v3] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Topic: [PATCH v3] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Index: AQHbJrkPZIUl6hhjQE6BArXHpLZSvg==
Date: Fri, 25 Oct 2024 08:37:00 +0000
Message-ID: <1a3890966d68b9f800d457cbf095746627495e18.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|BEUP281MB3428:EE_
x-ms-office365-filtering-correlation-id: ab1386fb-fc13-446f-d0f5-08dcf4d03187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0RjTmEvTzgyVTdpN29RTlVCVEEvU3BWekdKVEVWS1J1YWdrNWFzQnlTa2JP?=
 =?utf-8?B?amFvMlFNWWkzVm96b3ZaNWJ4b0QzNnNxQ1BNTEx4R3h0VWliY29UVlhJVG1B?=
 =?utf-8?B?cHd4K0hkK05DMkp4S21HLzlZYnBURmtrMVI5SnhoSXZWT2FUVGxRNnRqS3Zi?=
 =?utf-8?B?d1FLbTVmb0FoU2NkNXc5QTJPUW16S242R0VEZ1I1bjd2SWM1aXp2OFJOTVd0?=
 =?utf-8?B?NVh2TG96VS96djVCU2pTUXlseWJ1djNUd1RONk9WRkVGeWI5Y3BxdzZqQWlR?=
 =?utf-8?B?aFJwUlgwY0U2RkdmT25CcHc1YkxUdjJXeVNDT0xmTVdaRHR3Mno1ZE1FOWt6?=
 =?utf-8?B?R09DUlhpaUxoaitvU2ZQMjdXOG1USEg1YWhaaDZLUWYyblFsTjM2UXRmK2Nm?=
 =?utf-8?B?K0QrOW1LclZuNEJEZU81TVgvUnNmdEsyN05nZnlNZFpQcTJZU05paFJqc0ph?=
 =?utf-8?B?akltTkwyVkxVaTdLZmJ0WWdET1dKd2NSckRYVTN2eEl0Vmt3MzhER2ErLzhZ?=
 =?utf-8?B?SnhFUUl2RzZrZjkxWjJTQ2lweTRqcmtjN1BnK3U5VFJ4ZXZEN3FUVTlrVmJo?=
 =?utf-8?B?aU56YU80MmNYZzdrVis2amNDbG5XMi9xaWJOeEJ1b0NvbGJTTnR0bDhJUWpx?=
 =?utf-8?B?ZE9UbWJZYW03Mlp1b1cvY1ViN1hyekFQa0E0NldWOEFmZDQxNFRMeFJlT1Nq?=
 =?utf-8?B?akExclRTbllUNDEwVWEzRFRSdHVvdExMSHVWZ1EyRjcwdUp4MitOai80WEkv?=
 =?utf-8?B?ckZ3Q2Y5cWZNY2xZaVF5dVZ6Vi9WSEhvZU80elcrTmQ0enhoNExrRWN0czFC?=
 =?utf-8?B?MXNqZTVnZGtlMGhxbnRKMXhvK0ZyQm04cm1sSGROOTZrU3AvYVJPM2JtWDRZ?=
 =?utf-8?B?OVFzRkpXSlBQZnI5VWVNY2JxOEJSWGxVYlhzb0xIYnJYdEczTjk0YzRTbDRZ?=
 =?utf-8?B?Y3BmcnhEaHR4VE1nZU8vUzZFQ2Fpdjd3TTNjSnJWdkIwMXVEUWhqR1dBTTY3?=
 =?utf-8?B?UWtFNXRzdVZRN0lteklFNG10WVo4d0VORDE0cmpsQ0I5T0VXTjJZbGxDUzI5?=
 =?utf-8?B?RnZOajY2SjVmSGg1VEM3c2R2MlY4djI1Zk5lVHFZZUd0TGRkZmxYdTlwSzcy?=
 =?utf-8?B?d3Y0TUhRaDkxUG5tRVpxcEE1KzFzSVVPRkJ2eTZnSkNIQ0NrUTlYc1hiOTE1?=
 =?utf-8?B?cUFrbzI3VmVaaTkvd3dZb3RjMXRScklTN0ZhY1ZUNDRKQ3FKcWxsR2g3Mm1r?=
 =?utf-8?B?S2thWVovVTFOK1kweWpPTXpHQUpuZk1NcGIvbmhLMXJCZENuM3dYWXlZVnpH?=
 =?utf-8?B?TXBnWi83aXp5Zm42b0lvM1J0Z0FLTEI1TGRWZWpOWFRicWM1UW1rWkFjeXpP?=
 =?utf-8?B?d1o0b1dROVVtZlRDRk5sd1d6WjFOM0VtRktyOW5FNDVFaWZia0syS2dWNVo1?=
 =?utf-8?B?ZkVRY0hJbDNMUFpUd1RiMTlOM0FJZWJKN3pONUdOek1hR3hzRm9EZUo4c3J3?=
 =?utf-8?B?NHEyZDhVMlIzRHdKZXROQ1k2OFBKbFRkMjRqZm5tc3FkSTcxVjMvWkI1WS91?=
 =?utf-8?B?WUhsQi9ZbThLWHpSZ01wTlAyNTBPWi9qcXhTUnhLTUxzU3hwaHJxWE8rNTVF?=
 =?utf-8?B?THB6WkVFMkRQVFNCZnpFODcyNE85djhNa2xERU5hUG4vdnRsamwrM0hkUWNy?=
 =?utf-8?B?Q0JvQ0RxT21EZSs2YzMrQzl1QUlYMmRmaGlQY2F3Q1gxR3YrdmsxUVFvbnNV?=
 =?utf-8?B?MjkyTmpETjYxUEYzUjBZL2k0MWZpS3BPQldqUm5tZUJCZkZsK0tXbG45S21X?=
 =?utf-8?Q?QaphV/nNzqYTWug/cfyQsTi4bDPKSlxjoD/9Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXpPZnRDR1ZvZnJtbFZxTGg0d3FwQWx1dFc1d0N0b2F1TDQzSWhzRzRBbGM0?=
 =?utf-8?B?OTgwVm9qWFIvV1pqRlNyL29hMXkyTEtpK2lKNUdOMitoaHVJTFNKMVBWSkt2?=
 =?utf-8?B?cHhrUUUxR0xBSytEak5JTzFXYTlWTzN1MkZacHhHaTRUYnp5SlI0Y0hja3hG?=
 =?utf-8?B?UWJBZ2s0MlhhUmthbDRNSGZRQlNlV3l4UGdGcnl5MllXYzNCTkR5bTJ1Mkow?=
 =?utf-8?B?eFFJNXpKd25RcDdqVGxMTFB3WjRtMmt3cDFIUmhpcXNTb1ZzY0RhSVYzQm40?=
 =?utf-8?B?eWxMT2xWMnFOZy80UnNPNTZDWTRlQmJ1Wk5iNFYrTHJ0SngxdlA5eTFKTHkv?=
 =?utf-8?B?YWFsUE9qaEhTVTloWnY3Nnc1TGJpcDlQUnlDaVZLa1VzOFhOUXc3cEVrR2Nr?=
 =?utf-8?B?TTJlNHVTT2pFa0Nhb2Fpdmd2SkExYnYvSFJDYkNDQkt6Szdja0pMeHBpNFRv?=
 =?utf-8?B?UGliT25nRUJFSXRiOGk5RlZYMU1aSmlOcy9Xdm1DRmFRZ1c0elhPaW1sdDdu?=
 =?utf-8?B?dEQ4L1diYklQeXZuamFHVjlZalk4RHlPa1pwcGxMMTlQaXJJcjI1WldBNGp1?=
 =?utf-8?B?dkZFSEQ2dnFCazJ4VjdKSXlMUGFlUkhXek1LVnFvYUtWYVJsRnh3aDJMTEpZ?=
 =?utf-8?B?THBOSzd0S080WWdjbEpnT0RIS25ia3hsektZcTNZUEkwMkZCYVRRM0V1aVJ5?=
 =?utf-8?B?SEM3aXhsWUxDb2xvdDNZMDVYRE0vYjNPU2hJa2xHc0c0OEppZXBXcng1VUtp?=
 =?utf-8?B?OUx6dUpDK09EcXFNWXhvYm5RYUI3VkQyMnRUQmxKUE9td1R1ZkoxdWl4aFlh?=
 =?utf-8?B?TGZURnJMM3hndjRiQ291ZHZNZjRWcGNOejcwNTBFNFhJQmNuSjN0aklEVzE1?=
 =?utf-8?B?dXZkUlkxMzFOaFFmZXRDV1hkVENwWk1ESlhBV0Jad3hPSmJQWmFlMkN5T3Ir?=
 =?utf-8?B?K2ZOaTRpWUtZTHFJRTFwNDI3ZlV0OHE5T3k1STE3RmdkQUNyZDJnTCtDZTR0?=
 =?utf-8?B?eWNUcGI0K1JnUzkvNWJId2xGWVZQbFVZeUhnZGNHVjZlLzlETlQ4MVNIcE9j?=
 =?utf-8?B?dkZSWnJoUE5ZU001cmpES2FBdXhPN3ZRanMyMWc2TEdtZDRBL2VpZXZWMHdN?=
 =?utf-8?B?eURuVFp6Vzc4bEw0K2hMRml0ZmFmTlQ1cUVuMWZPenFLZzBHTi9DWWh1djN6?=
 =?utf-8?B?VmpscWNOeUFSYzBhelBEWlpxNC9raVNRRERrT2U3bXlEMG1PMGVmZmt3ZWNT?=
 =?utf-8?B?RmhXdlV3V1lzc0Iyb0pWSituUlNzMXpuTDM4MUhwSHRWdXBJdlJhaU9LaGpR?=
 =?utf-8?B?ZGhKUXFrMFB5ZytzdENTcTJGY0lFSUFYaUE2OVRkSVNubFZqR2Nrc1hwZlNw?=
 =?utf-8?B?TGVvM3pPR0EwTjVSdGlQY0JPSmRWRDNxSU05ZUFML0QveGxyTzJnclRHb3ZY?=
 =?utf-8?B?OG1JZGZWcENidVZhZUsyZWVEbXFObFZuUkxnbkdmRmFYN21XOENwZUgxMXpu?=
 =?utf-8?B?aHRwQ3UySUZ4MkpMaDVFNmNjN0JVOFBTWlpwSGkzQjVCaWgrSG01NVdmL0lU?=
 =?utf-8?B?bUMvM25OZmlEeFVSYVBaT1VYajlLYjZXSjgzc2dFUUdoZXFTNDlHVUhUQnJL?=
 =?utf-8?B?c3pBMUhkNkt3RVltWGhYSy82SGZYcUQ3VkhWRE5LQ0tua2czTDlPMEJSSDVX?=
 =?utf-8?B?dmJHSkRkU3F0MGp0Q1B3NFN5YWU2Sk1YMk1jWnlKOS9YeCtIcWszWEpsL0xM?=
 =?utf-8?B?TzAydU0wVGxYdjdZWUxGcEtScWkyazJIbnlVN25mZ1NPNndGeCs5S21Bb2pU?=
 =?utf-8?B?VGtEbDcvQXRPSTVkZEoxdHYycWNrbzl5VmdFVjAyR21hMHQvZHJHd1l1VUpQ?=
 =?utf-8?B?bXJmVEJBWXdCRFBzeitTWEEzRTZ2NG9idTJDaUtrUlFjVEhaUjE3NXNEOGlp?=
 =?utf-8?B?L2lCbC90S0hiT2FaNWdINXU3WGY2M2lUUDI1eW9JUHg1TTdmN1NXVFUzWDBC?=
 =?utf-8?B?VTl5Z3JaVmk1eWZGY0gwRFRGeTVrRUFRWkI1dHZBUGJsS1BsVkFrMXg2QnhE?=
 =?utf-8?B?eVdaMjdVTS9UTVZlSnR3aGI1aFY0Qkx4WWI5TC9UOFQxNWNORWhlQlRabk4v?=
 =?utf-8?B?c1F4c2Y0dTZSeW51SEN1U3NFZFM3QnZKRGx0OU13K3U1TGUzQVhrOGhXdGd1?=
 =?utf-8?Q?ofTppHKmLuYy8I3ztQfc8JA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F12D5495ED5D3459CD66AF9EB43A60C@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1386fb-fc13-446f-d0f5-08dcf4d03187
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:37:00.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MklkxNaifyVSi9kah6VqSur6IOaky9Eu6lRNV6Yj8Dx5FAm5zvH0w/FDaImu+Nus6M8EpnQU4XgfPHEWxu2UaWfhS9ktYzbcVEuFdAvDmL/ZBYnkI+6tcJK1JP8+eFFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3428

VGhlIG1vZHVsbyByZWdpc3RlciBkZWZpbmVzIHRoZSBwZXJpb2Qgb2YgdGhlIGVkZ2UtYWxpZ25l
ZCBQV00gbW9kZQ0KKHdoaWNoIGlzIHRoZSBvbmx5IG1vZGUgaW1wbGVtZW50ZWQpLiBUaGUgcmVm
ZXJlbmNlIG1hbnVhbCBzdGF0ZXM6DQoiVGhlIEVQV00gcGVyaW9kIGlzIGRldGVybWluZWQgYnkg
KE1PRCArIDAwMDFoKSAuLi4iIFNvIHRoZSB2YWx1ZSB0aGF0DQppcyB3cml0dGVuIHRvIHRoZSBN
T0QgcmVnaXN0ZXIgbXVzdCB0aGVyZWZvcmUgYmUgb25lIGxlc3MgdGhhbiB0aGUNCmNhbGN1bGF0
ZWQgcGVyaW9kIGxlbmd0aC4gUmV0dXJuIC1FSU5WQUwgaWYgdGhlIGNhbGN1bGF0ZWQgbGVuZ3Ro
IGlzDQphbHJlYWR5IHplcm8uDQpBIGNvcnJlY3QgTU9EVUxPIHZhbHVlIGlzIHBhcnRpY3VsYXJs
eSByZWxldmFudCBpZiB0aGUgUFdNIGhhcyB0byBvdXRwdXQNCmEgaGlnaCBmcmVxdWVuY3kgZHVl
IHRvIGEgbG93IHBlcmlvZCB2YWx1ZS4NCg0KRml4ZXM6IDczOGExY2ZlYzJlZCAoInB3bTogQWRk
IGkuTVggVFBNIFBXTSBkcml2ZXIgc3VwcG9ydCIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KU2lnbmVkLW9mZi1ieTogRXJpayBTY2h1bWFjaGVyIDxlcmlrLnNjaHVtYWNoZXJAaXJpcy1z
ZW5zaW5nLmNvbT4NCi0tLQ0KdjI6DQogLSBBZGQgRml4ZXM6IGFuZCBDYzogdGFncw0KdjM6DQog
LSBBZGQgcGVyaW9kX2NvdW50ID09IDAgY2hlY2sgYW5kIHJldHVybiAtRUlOVkFMDQoNCiBkcml2
ZXJzL3B3bS9wd20taW14LXRwbS5jIHwgNCArKystDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWlt
eC10cG0uYyBiL2RyaXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMNCmluZGV4IDk2ZWEzNDM4NTZmMC4u
N2VlN2I2NWI5YjkwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wd20vcHdtLWlteC10cG0uYw0KKysr
IGIvZHJpdmVycy9wd20vcHdtLWlteC10cG0uYw0KQEAgLTEwNiw3ICsxMDYsOSBAQCBzdGF0aWMg
aW50IHB3bV9pbXhfdHBtX3JvdW5kX3N0YXRlKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwNCiAJcC0+
cHJlc2NhbGUgPSBwcmVzY2FsZTsNCiANCiAJcGVyaW9kX2NvdW50ID0gKGNsb2NrX3VuaXQgKyAo
KDEgPDwgcHJlc2NhbGUpID4+IDEpKSA+PiBwcmVzY2FsZTsNCi0JcC0+bW9kID0gcGVyaW9kX2Nv
dW50Ow0KKwlpZiAocGVyaW9kX2NvdW50ID09IDApDQorCQlyZXR1cm4gLUVJTlZBTDsNCisJcC0+
bW9kID0gcGVyaW9kX2NvdW50IC0gMTsNCiANCiAJLyogY2FsY3VsYXRlIHJlYWwgcGVyaW9kIEhX
IGNhbiBzdXBwb3J0ICovDQogCXRtcCA9ICh1NjQpcGVyaW9kX2NvdW50IDw8IHByZXNjYWxlOw0K
LS0gDQoyLjQ3LjANCg0K

