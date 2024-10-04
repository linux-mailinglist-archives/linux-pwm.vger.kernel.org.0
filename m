Return-Path: <linux-pwm+bounces-3472-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB2990FCF
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 22:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92CD1C2311C
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 20:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B101C878E;
	Fri,  4 Oct 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBARbEMb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383873466;
	Fri,  4 Oct 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070555; cv=fail; b=kBIUCz6MCwHEzkt6SCei/ZtCs0XKlIBT2QAIKu1lpXqtSDg6pP8gV5wculerbNLXQNV118IGRIwILx3Az1NZduhxgerkysFkrCPAdsIK5AoN8ao/1KGctqg3bRy2rRqoXzfaZM2GPkka+nO8Owzevj2xqN/dL9w/LjqRkQzDN2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070555; c=relaxed/simple;
	bh=2K5Xs6ynqtBnznUvSCxGyUqzqTSbuWzq1c713oGuakk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D1CiOzJ0UJDWVRpDLZEMBU8xylwTApOraOnTOXe3mlFVQd9CfyI9L7kRbidTeaqTdkH8am7u3eNI1ZPU5pVYyzvwQ94/ZZOQDpkGBNOaVFwkIGuG7grrXUQnVQ2qofh8qqjQjQ1Tms/qyIqToYAW4/J1hbkW0cgWZ8JGkR+TNw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBARbEMb; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rprdCCn+aR75CiF0fypnRJqRRi1NQF+AgFviU26binxCVd0mNR/GeUN876oOEDGamexxQwAN5qCZoMajT9sFaN9kKwN4eUhKUmDiuFM/j7rOImdu8IxC20fH/K4sXST0sf9mhlFyn7iePd4ejGfm4EE3oP/KrikZSEC9k1AShYfYUdqu1f0yId0/PEjGo51uXVzabw9lkHP4HE/yfzj1byeL46p/WY4IQNyip5wBPnVMdTOKAa5+0IL/yhDDovsGLSMSU5yXG2P+iF1+chrkg5yD0MdQALQp34ICxsH4VKLfphveidaq0pyCOt3GYFdWCDgTQrrmrjZpXoKPuBdbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q49TfIINT6iI8oLu6wHk4SvR4hWXJ3iXD79wzZ8b6E=;
 b=YpkNDR5URYA++c7yqJzSRjJbnH+zEUvRKNGwrMD2vMhhGU9V3bUNTCaYG93/Yp3WTkouau51nqzfnhA6uN9TgQRZsYcsTHK5rqZ89NV+l5IXe+VrYKECvVEqHKXp7JJ0dr+fcdkzpF5PxrQvBOh2KxIMxwK0lt/PMkrT2VjcWmdJU36JyzhVb5FAUsVDuD5rpDFz9h9YlSrzBN40jSgRJX7kUWMz3FrlEU3u5kPwgOzyaFn0Bw+u4BNuHd4hjk2PZH8XGiIr2rBFmug33ciGl7AWHCk+v7qTArlno9SEhBN/FmJt8238WOXpkTejkNC5dfBC/NoOIBkN2MEjgp0hJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q49TfIINT6iI8oLu6wHk4SvR4hWXJ3iXD79wzZ8b6E=;
 b=gBARbEMbQc6Sf0M4/duEd7WFe5svbwvRXjHg0LUToMGL4swOKhTgErAtoEiL06Fl8FPJWAbJgznIya5DROKjmDDEYWLw+FFm/XyvMG7mP7YT2w9oqtj4rY9oVLpo8YUfQSY2lOv3AylontIbiPZP8mdtVQrfMyUmdnYjSTrT1e/+N+dB52FM8FDapWkcI3hnWOvu02Mr9XGTFHrI6tcaCXtybZc2sk6Fu5YPpGmIDWL7ol/zTncIFv1SxRU7GwoFhDYta85faDXi96nXBmn0y0priPpAYg3anEreB7uosliMGaAupGSt+w6U6wE7nLsXAolZRGjcoKF15QL1puLf5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8695.eurprd04.prod.outlook.com (2603:10a6:10:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 19:35:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 19:35:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: marex@denx.de
Cc: Frank.li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	francesco@dolcini.it,
	imx@lists.linux.dev,
	jun.li@nxp.com,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	ukleinek@kernel.org,
	xiaoning.wang@nxp.com
Subject: [PATCH v7 1/1] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date: Fri,  4 Oct 2024 15:35:31 -0400
Message-Id: <20241004193531.673488-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7ac0ea-d2fc-459f-67a1-08dce4abc045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0Y2enFUS3Qya1JVcHp5ZGMxUmwwYUpETzdHNHllZGlrMXNtMS92WGEvdEEz?=
 =?utf-8?B?MERQOUhianhKV3FQL0NJV1c1YjRzaS9IRVMrRnJjSm16VVcvSmJDbG9MTGFp?=
 =?utf-8?B?aVlLNmY2MlVJT0kwME1Kbk9FTHJxS1dENzNXVGN0eVlzMnMxYndMdWRlUFVR?=
 =?utf-8?B?WHJtSENLTXIwN3AvbFBTZmVjVjJ0ZUpoUkExVDRTbFdGTFd2UTl0YTcvaGs2?=
 =?utf-8?B?Z3JHUThQaVpuNCtLdmJDYklxNTk2cU1BS2svSGE0UGNPeUkveGFLZzQ5T2xl?=
 =?utf-8?B?cEJuT1licUhGKzFXWlZES2FjTk5aSTVnb3ZZeXovVUFLSm14OHB3R21JQkda?=
 =?utf-8?B?NVgvWEhSYUtFZVhJbHgrQ1ZmNVRFVGUzUlJMeG9uKzZHRkNxaitDLytmYU85?=
 =?utf-8?B?MG9lSUhaaGRPUUlDNVhNOVpXS0l4OWY0cWliZ2Z6emRSNUZGSm9Leit5UTdl?=
 =?utf-8?B?ZUIxaWVhZUxBTEVKcHoweDF1YzJtWkZYK21qQk5QNWFpZkJ1N29uaEM0V1hP?=
 =?utf-8?B?a09sY1FyMEV6clVGdTVtQnF6V1RoSVZMRXhwZTMzSm90TjJJWG1aRXRncmlt?=
 =?utf-8?B?dW1HU1g4QWVtQUg5Y0FmSDJFbmppYkltaS9QR01FWWtPaFlGTVlaL0hLdVZ4?=
 =?utf-8?B?Tzh5eTRwV2g4SHcvZ2E5VlVLTzBvVSt1RDcvb2lTL0JtaGdjOGZMTWhXRGp0?=
 =?utf-8?B?aUpuS1luU1ptTmVNYm01QTJxcmNaeDlXTDZiamNEYnFwQXFQVjZkaHNSdkUv?=
 =?utf-8?B?MlpWbVFiYXFzaHFmWkpJVmlYeEdxOHRCMElRdGRUM2JoaTFicVI1VTgzbkNU?=
 =?utf-8?B?TVJHNk5Mc0FMRFB2eFJHZThUaERCN0ZwNUV3WlY3SkFDaTZobTFkbVFmV0d1?=
 =?utf-8?B?TUN6b3UyU0JhU3ZUN1dQS3Uzd1dPaFMzNjZzSmxGcXVJdWhacFZTWEFFRXha?=
 =?utf-8?B?UDdYZWFBbTJidU1kaDN1VGd4cjNHbDcyL0Z1OHJpVVQydldOQWhtL0VoaVpJ?=
 =?utf-8?B?cEtMeG9HaHZkdHo2eWwzL29EZGxLOEtkYytNSmVseFVBamVINXRCUjZUNHdp?=
 =?utf-8?B?K3FPSk5PL0Mya0s1cTJsMmRvYjdVWVhqVjFrUDhvRWFIMnMrWll5MlB0Ym81?=
 =?utf-8?B?b2tGRDJWKzRHU3RKUkNXNHZUeDZWVTBEV3hiMDI1MHVXcmdEWE9qSTM0UVZ1?=
 =?utf-8?B?SWM4RFFEOWd1d0hxRlMrQ2QrTlRVRHdVL25Mb0h0WElLeWhybXYyQWJWdStU?=
 =?utf-8?B?aksvYktOeG9ENkgvVXo5a2JLVDhxVVU2WW5LaUZCL0NQd092V3pTSTFzNTB3?=
 =?utf-8?B?ZWVld2N2SXVwT0Zib0VxWk85ZGErUXBwQmIwVVRZcHVoM3JvNU1sWjMyWERP?=
 =?utf-8?B?dUtsQlJNdERqTVhTL3BuNHhSQnYwS2hUMlVLVmc5b2RFeDZ4Y3VRb3A2Q1pi?=
 =?utf-8?B?Sm8xVHdoRVNSUUVEVVNHSE81c0xhRFdmbUxxNTBreHIrTlFmLzZScUZJSFNJ?=
 =?utf-8?B?dWtKTEV5N2tKWGR2OVVjZ3A5emx5bGpaSUdVeWw5ZXlKMlZTeU9kQ1VmWGE3?=
 =?utf-8?B?SHRTcWZhNXBkMTBNcThJeHpYM0J0bjlncWtGV0Yyb05pRUpUekpDeENXQTBm?=
 =?utf-8?B?aEN4Zndnc0tCWUtvSU9PNHorMmxUTlBNdGJlUFVSbHJXUHhyQ1NVd0hkdlVK?=
 =?utf-8?B?QmpzZVIwSzFkMTcvb2ZWb3dtOXVIMmpyTnFqOStCTWtHY1VRODYvOWVGVHdy?=
 =?utf-8?B?QkdQNEpGditNdFBlZWVFYnIyd1lVNUNQbXRKK2NrcEY3NXg1aEtvZHQxaG53?=
 =?utf-8?B?RUV5dFRjMTJiZnFiUUQ3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNwc2lDL3hzY3ZMWHFMTGdMTzBrMUdKbDJOS1ZweDhNMU15NjNKVlpBWDl2?=
 =?utf-8?B?ZGorRWs3bUVrcmt4eUJTVTlrdEtRUzRFVXNNMXgvc3pRVDJzS2h1ck1waGRC?=
 =?utf-8?B?eVN3aWxCZXhpUnJ4WTExSDZIS2VuRjV6emZQM09jZEFaSytFaHVKV2M5RHZZ?=
 =?utf-8?B?Vk82ZWdWdkN6bVpCelpZQW52NFhjTU9QeGRGK1ZtUXVQMTNMb2d6WkxnYmxy?=
 =?utf-8?B?WDh4dmw5aVFib3c2Zm1rbHhVRWduU2c4bDFaQisxZHpuVHdSWmVndVpmbGxr?=
 =?utf-8?B?S2pKU2pRUmNOZmVnNTZhSmt1dklkcktvSmJmaXRMbFhNd3lEVHJZNmpqRGhB?=
 =?utf-8?B?RGh6Q2FCSHFpS3JIdjdHT1NmZVpWT0tNTnd4b3dycWZZR2gzYldBZlFhMTlM?=
 =?utf-8?B?SjhLUisrcmFob1Nkam9EdXQrQnc1Ri9LMll5TTFNOXJHMHFUVS9qRXJZaFR0?=
 =?utf-8?B?L3o1cmxOOUx2eHYwbWl0bDVaeG8raXFBcUVtWHhIVEtlMUoxZUVGNi9TRjNN?=
 =?utf-8?B?S0M0MWVGZzYwOHQzamlvaENNcmM5YWppY2c5aTIzV0FKdHU1M05aNUpnZXNG?=
 =?utf-8?B?QU9JbTBpM042bDBPTDkzeHNpSWJZZWdGUDdJM3p2YXlRQ3RhN2s4YlZtRkg3?=
 =?utf-8?B?aG1lVVJVelZsZ2FtYkNuODhPNDlMRG5sdXRXN3V0L1ZVUHB4UzBQMXB3Z0hn?=
 =?utf-8?B?amFGT2JrSWpBdlVHRTJXSFpmOWsxeUNCRlArK2JhUE5Ba1lrb2pBRmI0bitN?=
 =?utf-8?B?SWZjUzRpbUVDTDZIc0s4elhhVjhHY3FseG0yQmlieXBCOWprLzU0UWRuM0s4?=
 =?utf-8?B?T0lKVngwNEdhWnVMR2NUcDJQR3c0TXBnTG9VTHZ4U21oNWlKWjBJWjV1RkZD?=
 =?utf-8?B?ejhEanFxZHdGQys3dXhQNEJma2poNzFMMVpaaStPWENtbVQ0WDNRQ3ZpWno3?=
 =?utf-8?B?UkZQNHJUMEw1eGZqb0JGQlRVanFTUURnKy8wL0FKSjhQUnlRdXlIY3lVdlZ6?=
 =?utf-8?B?L3g5SzNQOWlORlZRSlNDMTk1a0lueTk5QnZBbjRhTnF0Rnh0T1dNODBrQ2tx?=
 =?utf-8?B?ZnIrdmphbjlJS3dMUkV1YmZMMWNRL21MMkxXOXFZblNTYzd4Q1htYThGTWJm?=
 =?utf-8?B?VDRmVisrZVhMdzd1VlNsMGtDSnpRYUJDaDVYRmIwVnVIV1prOXZGTmp3NUxa?=
 =?utf-8?B?cXFOdGo0VXFidWdEQ2tKODZjckE4Q1hvQkVkM0ZDS2wyd0pZSTVUOUlyOU1E?=
 =?utf-8?B?bnRTd2M3SytTRDNJN3ZKZmxJcGpUYkxkems5VzljMVdKWVpNampFMkEzQ2ZF?=
 =?utf-8?B?dU5jcXZyeERNK01jMitTZ1RLT3l0anNlQlQyMmUxTi9ZY1R3RXVuODUyNGtw?=
 =?utf-8?B?bGJwQXNqMStPcTUzL1h0d1RHa1N6b0VUbGFxcTdhZmdkN1h6UjljVGpSTzVa?=
 =?utf-8?B?WVh3Qi9hS0hBeVYxcUtBMkRBZ1F4Q0xtd01zVm9DVVdmZi9nRXVOcmozRkQv?=
 =?utf-8?B?K2xKWGwrU1pHaTkwTXlwRk9BdTJTditTN0VITml4NGtoVlpNZ0wzRzlVQjN6?=
 =?utf-8?B?VWlFTUoyYjFIenpUd3RpanFNZzdmd1BlTnZrUko2T0pwQWdMTjgvcjZNd3Z6?=
 =?utf-8?B?S0JJU3hJN2xLUXY3L3lDeGVNV1cwREhQajJ2ZXhDaGZzOWYwejFvT3J0cXJT?=
 =?utf-8?B?QjlKNGRDVjM3RWRnTUg1cTBXb2xsWkNjcFBvRTNRT3NqdG0zdS9DSkx4Y3Z3?=
 =?utf-8?B?RXc1TWpWUWl3alZQOWN0OW5ybXNSL1NRVDBHN1YvSWZnRU1YZGlwd0dkN0dU?=
 =?utf-8?B?UWxSSkZiTDRMVGRyelJCNnpIZ0F3NVExdlVmdUxQNjZoTXdib2hTTFNBOXJZ?=
 =?utf-8?B?WC82azhHS0dBUWUwN1hpRDM2VC94ODJ2aTdGWjdOdzRrUXY0VGdPaUVsd05U?=
 =?utf-8?B?OWdrbHV4cWM4MWNXdjdkZlBlQUtCVzJna1V3Rkg0QTB4cWVpZ3JwRHFtWjhr?=
 =?utf-8?B?QndHWSsreERIWlVIOEpRY3lxaVRZL1Nna21FeDR1Q1c4czJmS1NaR1hyYnEv?=
 =?utf-8?B?anpTRWhFRXRKYVFCbmJsbDh4MXZvYVZzcHpnL0s4L3NPdWU5VjNsZmI0NEN0?=
 =?utf-8?Q?ul78=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7ac0ea-d2fc-459f-67a1-08dce4abc045
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:35:49.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CEmh1UY1SS4t+npBYWBeelX5eawgYA1DlevpiYoka9k/mxyFZ/QmnNPsmy4FU1C8e6V6zadX1dpx4QRyL593A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8695

From: Clark Wang <xiaoning.wang@nxp.com>

Implement workaround for ERR051198
(https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)

PWM output may not function correctly if the FIFO is empty when a new SAR
value is programmed

Description:
  When the PWM FIFO is empty, a new value programmed to the PWM Sample
  register (PWM_PWMSAR) will be directly applied even if the current timer
  period has not expired. If the new SAMPLE value programmed in the
  PWM_PWMSAR register is less than the previous value, and the PWM counter
  register (PWM_PWMCNR) that contains the current COUNT value is greater
  than the new programmed SAMPLE value, the current period will not flip
  the level. This may result in an output pulse with a duty cycle of 100%.

Workaround:
  Program the current SAMPLE value in the PWM_PWMSAR register before
  updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
  register. This will ensure that the new SAMPLE value is modified during
  a non-empty FIFO, and can be successfully updated after the period
  expires.

Write the old SAR value before updating the new duty cycle to SAR. This
avoids writing the new value into an empty FIFO.

This only resolves the issue when the PWM period is longer than 2us
(or <500kHz) because write register is not quick enough when PWM period is
very short.

Reproduce steps:
  cd /sys/class/pwm/pwmchip1/pwm0
  echo 2000000000 > period     # It is easy to observe by using long period
  echo 1000000000 > duty_cycle
  echo 1 > enable
  echo  800000000 > duty_cycle # One full high plus will be seen by scope

Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v7
- Add continue write for < 500hz case to try best to workaround this
problem.

Change from v5 to v6
- KHz to KHz
- sar to SAR
- move comments above if

Change from v4 to v5
- fix typo PMW & If
- using imx->mmio_base + MX3_PWMSAR

Change from v3 to v4
- none, wrong bump version number
Change from v2 to v3
- simple workaround implement.
- add reproduce steps.

Change from v1 to v2
- address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
  About disable/enable pwm instead of disable/enable irq:
  Some pmw periphal may sensitive to period. Disable/enable pwm will
increase period, althouhg it is okay for most case, such as LED backlight
or FAN speed. But some device such servo may require strict period.

- address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
  Using official errata number
  fix typo 'filp'
  add {} for else

I supposed fixed all previous issues, let me know if I missed one.
---
 drivers/pwm/pwm-imx27.c | 75 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 9e2bbf5b4a8ce..00a7189ba46ca 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -26,6 +26,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -263,7 +266,77 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	/*
+	 * This is a limited workaround. When the SAR FIFO is empty, the new
+	 * write value will be directly applied to SAR even the current period
+	 * is not over.
+	 *
+	 *           ─────────────────────┐
+	 * PWM OUTPUT                     │
+	 *                                └─────────────────────────
+	 *
+	 *           ┌──────────────────────────────────────────────┐
+	 * Counter   │       XXXXXXXXXXXXXX                         │
+	 *           └──────────────────────────────────────────────┘
+	 *                   ▲            ▲
+	 *                   │            │
+	 *                 New SAR      Old SAR
+	 *
+	 *           XXXX  Errata happen window
+	 *
+	 * If the new SAR value is less than the old one, and the counter is
+	 * greater than the new SAR value (see above diagram XXXX), the current
+	 * period will not flip the level. This will result in a pulse with a
+	 * duty cycle of 100%.
+	 *
+	 * Check new SAR less than old SAR and current counter is in errata
+	 * windows, write extra old SAR into FIFO and new SAR will effect at
+	 * next period.
+	 *
+	 * Sometime period is quite long, such as over 1 second. If add old SAR
+	 * into FIFO unconditional, new SAR have to wait for next period. It
+	 * may be too long.
+	 *
+	 * Turn off the interrupt to ensure that not IRQ and schedule happen
+	 * during above operations. If any irq and schedule happen, counter
+	 * in PWM will be out of data and take wrong action.
+	 *
+	 * Add a safety margin 1.5us because it needs some time to complete
+	 * IO write.
+	 *
+	 * Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest PWM frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500kHz), this workaround
+	 * can solve this problem. No software workaround is available if PWM
+	 * period is shorter than IO write.
+	 */
+	c = clkrate * 1500;
+	do_div(c, NSEC_PER_SEC);
+
+	local_irq_save(flags);
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+
+	if (duty_cycles < imx->duty_cycle) {
+		if (state->period < 2000) { /* 2000ns = 500 kHz */
+			/* Best effort attempt to fix up >500 kHz case */
+			udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
+			writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+			writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+		} else if (val < MX3_PWMSR_FIFOAV_2WORDS) {
+			val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
+			/*
+			 * If counter is close to period, controller may roll over when
+			 * next IO write.
+			 */
+			if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
+			    val + c >= period_cycles)
+				writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+		}
+	}
+	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	local_irq_restore(flags);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
-- 
2.34.1


