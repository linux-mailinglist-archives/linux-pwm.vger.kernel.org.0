Return-Path: <linux-pwm+bounces-7596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5059C392AD
	for <lists+linux-pwm@lfdr.de>; Thu, 06 Nov 2025 06:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734524E0EE4
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Nov 2025 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED22D6E64;
	Thu,  6 Nov 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kzjC0M1E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="p0R9zZon"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383712B94;
	Thu,  6 Nov 2025 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762407250; cv=fail; b=aEZU9OvTTsQgrjz1/FDbXRPs8IXN+yyqHSG/8fTGVbV7tVm+cTgNoUTz3NKBeO2gQW0eRjXeh8R1Tj/PRNLq7vXVnmXnHGlpOL2/rzJdokx8v/tH2h4DbMoQAptwvEflRyJoZLiaa8z5mlqpcXWTv6Xs04JMhRlAwMxnrq6EbDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762407250; c=relaxed/simple;
	bh=oMYMLtJjkiXqTJmg4czMgcEx5xLAXCNmWbi7Td0iZvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IU+5KqyLa5dF8K2i0VY2RfpMTiELMFoKZvH8n7LsyrG3RvZp62/AMnsAo4Qpi78bCYGAk7ob4iE2dg90kocQKHwpPZweNKVMTCxQ9RkK16Vcnx2vnkCAkriPfdcyvw0lNTg/weDx9Qg84Al4QTfVDdPvu8Xk6S54KvD5sh/tUVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kzjC0M1E; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=p0R9zZon; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 31b9d2f4bad211f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oMYMLtJjkiXqTJmg4czMgcEx5xLAXCNmWbi7Td0iZvM=;
	b=kzjC0M1E3z94UNf3oKwsISzoIU0ozEbNb5JTpilklpI3kMQVoyPxLeqxYZUOzJDse6z2m3SEUURiAL+4v66MI0IF9ln0ECvf/LgSuenrcjVn7csTfeNaugL9KpZ6e2hLpRuh7dG+YLONPiWHpngOLKvOLdds//g3BXs8KlRO6P4=;
X-CID-CACHE: Type:Local,Time:202511061333+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2021e217-e523-491d-8a19-bfaa4479fed3,IP:0,UR
	L:0,TC:0,Content:11,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-META: VersionHash:a9d874c,CLOUDID:25fe186b-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:3|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 31b9d2f4bad211f08ac0a938fc7cd336-20251106
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1833995332; Thu, 06 Nov 2025 13:33:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 13:33:57 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 13:33:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHgDRNDdg29HdXxIi5swoGs4Pk1ztkDn2cnCNPqqdeQni9OaDj1LLEIZUa+ZtjI//cTSzUn7EEK/xiqi2zslsqGjOg49A6jKhhr0Bwl4l5k62WucE35lzhN1vfBcGod1Con2mYl/DtCWseEMJu/9GcOWdiPeATmYBqpwVww/Cpz5a4dSp8w+tqCwW5IAwyL6nWNzCGptw/hxXM2QnG6x8NwLmm56uMdZiXnL6sZSGMcelXZq25LWBHcMpUG2ZFiGlDK3dyCon7PCKu7hKiZcQEwcDh0hHZi5uBRKZ3sAQl64Od3yxiCQ2WJlj91hI1T2hdyMC7isLpdDfHDaNnhexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMYMLtJjkiXqTJmg4czMgcEx5xLAXCNmWbi7Td0iZvM=;
 b=NF+s+nqU4j1RnKBCzYQelYnE9LowTXRYOAHQnYdPmJ4fABYlylX0AoEpMTHOVa3riGaSvM80Nsql+9qWTiNC0FDBd2R8hr9rNldkHfZbqW5cTlemC0q6/MG5TP/9Pb0H3fAN8u0u09U9N459geOuKo6CxX8E1HmAU5hnS5i+1JPMCxgUFi5d029NeuY4poCr1oF8Trz2WLgCLLlApekuVJKQe7xTDZdRBQnSLxDmW+a/pVBPNeTEwFzpOemmwszXz6JYykATOb9P6/YoXWH3NHxThUaSZ5cGrXDDzZDIifiuTVuQaK+rqP1JLNYhyOVtreCdUItgxHmzX/MsFKkLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMYMLtJjkiXqTJmg4czMgcEx5xLAXCNmWbi7Td0iZvM=;
 b=p0R9zZons2kQGn2ITIZULzGJwDFe/8mrZdSplpxUMpB2sAVxDxU/BSK8iHZpbmFyIJnCfFUV6cpsSkHaqJSl+Mx2KJSe0puOIX3yCAXZbgC6jU5jG3yS4qQKtT6hKiCjWiZUgv11APp56fA54krdCCMd3qfvyoInCti7QeW7F0s=
Received: from SG2PR03MB6326.apcprd03.prod.outlook.com (2603:1096:4:176::14)
 by SI2PR03MB6614.apcprd03.prod.outlook.com (2603:1096:4:1e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 05:33:51 +0000
Received: from SG2PR03MB6326.apcprd03.prod.outlook.com
 ([fe80::7452:609e:ecaf:7103]) by SG2PR03MB6326.apcprd03.prod.outlook.com
 ([fe80::7452:609e:ecaf:7103%4]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 05:33:50 +0000
From: =?utf-8?B?SmggSHN1ICjoqLHluIzlrZwp?= <Jh.Hsu@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
	<Andrew-CT.Chen@mediatek.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	=?utf-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= <Zhiyong.Tao@mediatek.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "andy@kernel.org"
	<andy@kernel.org>, =?utf-8?B?TGFsYSBMaW4gKOael+engOiKrCk=?=
	<Lala.Lin@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"srini@kernel.org" <srini@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>
Subject: Re: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Thread-Topic: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Thread-Index: AQHcSaOp1Vthoe3gBUqff+IAb2o1qbTbGTmAgAiZAYCAAMQPAIAAtEqA
Date: Thu, 6 Nov 2025 05:33:50 +0000
Message-ID: <49022cbd70fbd06fd066872c9d9cf1919f7ff75c.camel@mediatek.com>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
	 <20251030-deodorant-unglazed-190cbfb4a69b@spud>
	 <d75decc54a4fc129e5f011cd6e91191896203b48.camel@mediatek.com>
	 <20251105-unbolted-kosher-8812a5349106@spud>
In-Reply-To: <20251105-unbolted-kosher-8812a5349106@spud>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6326:EE_|SI2PR03MB6614:EE_
x-ms-office365-filtering-correlation-id: c0ec75b7-8bf4-4bac-b725-08de1cf610dc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|42112799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RVBTbVVvTkRkMzdMVVZPZUxXUVd3OGZtZUVLbm1aNUg3akpRSWFCT3Zod2pv?=
 =?utf-8?B?ZFAwY2hjaGpVQVBpQzRJV1BEL3RWV3dJVytTYmd2cTVCZWFIQ2tYaGszZC9I?=
 =?utf-8?B?MGdRUlYrOWJJZDhPbmdCMEdyWEdWWjRZeGFvYVNWd2h4cXJxcXdYVko4YnVT?=
 =?utf-8?B?Z1ZBSnBpNzcza3FUeEwxWDRZUmh4NVc3ZExmYkpLMERNRHpFZ0hER09abVZl?=
 =?utf-8?B?T3ZYMWRIOGNrbFdBdG9VRlh0TW9USXhBZEVQb2FETnBITHY1dzNRKzUzb1hj?=
 =?utf-8?B?TzUrMlhwQ08yaWwrU3IzeUM5bmJCcHFqY2M2R0pmZ3RMUWdlenA5ajZscTFD?=
 =?utf-8?B?TVhxTW4xR3dmaUFPSjBKMDlUbzhSbDYwYkxGaW9CY2xjTWczOWZEUXNEeWVX?=
 =?utf-8?B?RzFXeldKcVZ6bUwvaFh4ek9yQ3pXdzd0QzR0a29KT281MUlrZHJLNGRacFhE?=
 =?utf-8?B?eHRlV2ZyM1QzTld1b3FqN0JoZUV1WVFycXhVQU9XTTlNUkd2NWRtK2p3aWQ4?=
 =?utf-8?B?K2xnSVdqVUNwdWxtSjBmTDVWdjlubFhZL3ZOZmViVmFRWVBJVm16c2ZObTJ6?=
 =?utf-8?B?Z2xxVlNRR0FubXRRbXhheXdrdStScHZJSHpCT2hiUXFCend2aWM0dkF4R1N0?=
 =?utf-8?B?VVQ1bGN3VzNteDBYV0JaSldKaGM2OWFVbGFWKytKWDRkdkpuTVdkME9nbVVK?=
 =?utf-8?B?eVJsVGswanN3S3BWWWFnYkZ4N2trbEt3SlBNbStIaWQxRWcvMlIyNnZzMTRE?=
 =?utf-8?B?TVRUekJkZ0owSjFpL2dxczZCN1IrNzkzZWxsRXhhN0UyWU1kRHNVZmppSmI4?=
 =?utf-8?B?QWZJamphMW9TbFJRcFFXdmErcHR6VnNvMmhGOVRaRkI0YnZzRXM1ZGh3aXBJ?=
 =?utf-8?B?Q1pDRE1YNXVqa3F3aWFWa01TdWtwZHlma2VuUHcrZWZvQlQ5UnNwdVFud2pF?=
 =?utf-8?B?Z2dUSjZKcVhHdVpLSHpqbUFma0NqaE9Rc0c1T3o2NlU0dkNjUis0MEcvSUVM?=
 =?utf-8?B?OCs1VWpERjlJVndabmlzOVJCNWJNWjd0TENRdU5ySld6NXdLSFRqNEFDL1k2?=
 =?utf-8?B?bTBTZ2RlRGp1RVU4RjJRU0wzcUdvTDZHOGlQK212VlJrdWx6R2hvajhtdG5a?=
 =?utf-8?B?Wi90U3A2c1FPeUxGbkl3NG1BOEtiQTFEMEk3UVJzcU8vZTgrOFJRRTdnK200?=
 =?utf-8?B?WEptaElkTUlHalJqSUQvZTg5aWhRRldDeU81ak00RlJoRm8vblB6MWVWZi9G?=
 =?utf-8?B?eTM2QUFVUDJxVkFEVERyS1NIbE1jd21GSEJoeTlRRk5tNkY3eDB5WGxleldo?=
 =?utf-8?B?QWpoZENDS0xzS0tPbmJMZUhrVlIxbEZmU3J6Tnp1RUpTQk5mTVRoOEM3aWR4?=
 =?utf-8?B?ajM5MWw2QkdjS2RVRUtLdldsdmJHZ0wzSVh6S05JeGN4V1RaNmdJQythRU4v?=
 =?utf-8?B?R2M5cHlnaTlhb2h3REJiVHpVbUpseUM4TXpLYWt5eEtXN1R5aWZjNmtLRisz?=
 =?utf-8?B?RHZPWkdjN2w3aEhlTE11RDYxREN4STNzMTRZUFlJSGFJZ0VudE91YkJUOXdj?=
 =?utf-8?B?L1V1b3Z5SkxUMmxsLzNqZ0tiZFo5ZFNtMDB0dC92TlFUQmRsQmNQU0RxdThY?=
 =?utf-8?B?akRDaWJLVXUvdmtnbjMwLzM0S1BET0N4QnMxUnBFTE5RMWVSbHloSGdUbmNK?=
 =?utf-8?B?TzRoRW1jTkNGamVTOTJsb1N0dEhhSy8vTEdOSzVReXo5V3Rlc2p4U3J4LzJx?=
 =?utf-8?B?QkdMZmk1RERjTU1XRm1UZEdUNTd2R2NMdTdrK3NrMHhUZVZmVDBLalEwa1dl?=
 =?utf-8?B?WnRFZ1RGYUcvMjlpVG1hYXVRb0NkTFVoYTFWVG5LejVTNi9VcVV1M200Qjlu?=
 =?utf-8?B?WkUvR3VnNnRTK01qd252aEsxY2F4S2pRbE5aUUM3dDhhMHNXT2U2bzRDaHlJ?=
 =?utf-8?B?YzFhZ3N4ZWltdjd6SEJQNkJmUTJBcEhnVGhKakNxOEV4YlJvZEJPUEZzdmZa?=
 =?utf-8?B?Z2gvMmJOWnlWdllwMUFNSFhodGpsNURSQ0dkWGlPTUR2cTYzS2VLYTJQZDhK?=
 =?utf-8?Q?82uv1E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6326.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(42112799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFpZNDc4cDgvcy80ZjZzemVFVkRDdlhPbjFVeUczbkdlUDBtdVBJZkNkZTJE?=
 =?utf-8?B?ZFRDU0RTQm1QU2lvNFQ2eG11NXBVMC9OUWVCelo4MnEyemVwVCtwOGxUaFV0?=
 =?utf-8?B?ZU1IM2p0VGNTVkhSeFAyY2pxWkZZTkxFZzFXVTluV2M2KytYWHNZd2lyVzdh?=
 =?utf-8?B?OCtmcXpDNC81RVB3VUZKaHh1cW84cE1PczFKQjBGQ2d0NkVYTllPUU5CNVMw?=
 =?utf-8?B?YXg1bDZMOVBCd3dHTkRUSlROOXhYVzlHSWxjRS9zdkVNN2Q1MGlsbW1OV2NZ?=
 =?utf-8?B?aiswY3c2MHFpK0ErblY0dkREZ24rUFJOM1NYZUxGdDdZdG4rcWR1S3ViSDNw?=
 =?utf-8?B?aEtiTkhQak9XNDE3RVAyQ1hnd29Fb0F4Q2tOU1c3ZGNlR1FiT3krb2tHdndX?=
 =?utf-8?B?VlgySEpwOWVNUXNFWSswVzJHcEJReE9lVFU4RkFnUmNFVmV6b0xEdE9jWnMw?=
 =?utf-8?B?Y3pMS2tKeTN1L0VUckZHK2hrRm5weHUzd21kMEIyQ05UcjdDTFJFSi9MR0Ir?=
 =?utf-8?B?QktxWnhoSHJRRnlSUW1ZZkRMcUN5ZW81VHdJdTZBWjFGUlFvM2J5WEIvT0xw?=
 =?utf-8?B?RTA2UGtwS1RDUXFWMmZUc0paZTZOeDgzQUhyUFF5K3crNC9ZWkRpK2VyYUpF?=
 =?utf-8?B?WWtISi9sM2NvY012VnVSMDVUaWYyRi9XNExUNFBuNm9sSXhtV28venNnMDRP?=
 =?utf-8?B?TjI3eHhpbXc1QWpjK2paZDBFQW9VQjlrVzJCQTdsNTUwL2VBWk9Wd3hpWmF2?=
 =?utf-8?B?TWVZenVKTUUxdWZXSlFPSFZxekNrTHpQclZFWGFHOHhoZWNrOHVCR2NNSzZz?=
 =?utf-8?B?SHE2eDNTVXpPdXo4ZExBQjJMZDl2d1ViT21GdTlIUnZNNVR2eEUzRUkwNGRF?=
 =?utf-8?B?SkNUU3VlT0JWL1JRS2NCL3FvSlI0OFpaVVZKck95cm5ubVlJSXN3QndNc3Qw?=
 =?utf-8?B?MGhPOXhJbFk5U1JaVVFxRWxTMnIzOWNLQTNMaUU5ME5rekNZbnN2Yld3cGRn?=
 =?utf-8?B?VnlOOFBlOWxGM1lxZWtBaytzNHdMNnJReEFVekt3c3J4K0g3aVFkeG5nRWJy?=
 =?utf-8?B?a1FPdlU1ckorOGpzTDdIVlU4Y2J4WGpaTzZka1dmUFF3MEtCakFWNjlQNUFE?=
 =?utf-8?B?V21LY3Zjd2Zzb05tTFI0NUw2MTRxWEtWZTdlU1pGRTVhTVpkVVF0Mk0zdzhQ?=
 =?utf-8?B?RWJ3dFlDcERjeHFmWGwwSVlmanFVZkg1Q0NvaCtPSzZSdDNYV050QVoyTEhF?=
 =?utf-8?B?UGR1VjRxQnRqYk5kWVhFT2FaVHducXd5NGFOc1BJcm9pWVliWG53L1hTK2Iv?=
 =?utf-8?B?UEl1S1RqbC9FWVNnRTA1NUNFOW5pWVJHSXByU0g2M2h1eEljSVdFdThTSUhG?=
 =?utf-8?B?VmtXam5OYlBzcWJNNVpBKzRDQjhaR2JBOGpqQXVJNnBkams4b0JEeklyaGF1?=
 =?utf-8?B?bGI1bytQMGxWcjV5S1M5UENXaTFzVFdEOUxnWGk3UHM3Q2tOVGpkZWlwMzNV?=
 =?utf-8?B?ZXhFRkxMdmYvdzdNUXNNZTBtSXVCY1hsUkU5UkpwcXJiVldxU09hZ3crQ2lX?=
 =?utf-8?B?LzRZcXo0bWhrYnFjeTZDbjY5MGllTjBNNFpjWXRkUzh0ZldIeGFwbDdWVEdr?=
 =?utf-8?B?azJVNzhBRkJ4OWF3RUt0eFc3OS9rYjZRNkN2c1FtVVhkSTlQQ0dCL0hIejdw?=
 =?utf-8?B?MkxvUi8yRU5FL3czRUF1WXV3K09XVkdGRUF2Wk5Xb2lXaG5ja0IzTkE3YlBk?=
 =?utf-8?B?V2xiZW13dDNITlprM3ppRWFtL1N1ZjFiQld5VzV1ZisyUldDL3lvd1hMRnZ5?=
 =?utf-8?B?bVFSVGZVWXdMUkZJSlJPL3BHMFM4SndNOG9OejdiWlREV2VEUnByKzhWWW5l?=
 =?utf-8?B?SWFWTGN2cUpDMkdpVllZdUhLOHdVb3dpK0R2RDRwMHA2c2FtbWw4Z0xJcEJL?=
 =?utf-8?B?VVRtMnZpZVBXY2JBVUVXRzg3bng4T0NUaTJ4akNVYnJEYlp0MTJmVmhnTHR0?=
 =?utf-8?B?c3BqNHJRV2hTeUw1YXpxcEhlSGhpVXdHNkZURFJOZkhOZWhPaHR1UHRTdDJ6?=
 =?utf-8?B?QTAzY0w3UWZQdFNwNHZTN01mbyt5TmZwWk82OU5VUTNiTG81Z2tlWVR2TENr?=
 =?utf-8?B?QlRJVzhuOVFxb0IyYzhVRklTOWpWSDZzN2RmMmdqRXZ5MTE5bWRSbVdRMmUx?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <942811483E3C3947AEFF4904BC743BA4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6326.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ec75b7-8bf4-4bac-b725-08de1cf610dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 05:33:50.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lS8GpuJGBlesYtxE8eUdrosUI4Fo+7jBa0WfglG/QT2FFyN5MAyiiV/dTp4XDKJDn3N/J8tj7pbD+xWmJcCMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6614

T24gV2VkLCAyMDI1LTExLTA1IGF0IDE4OjQ4ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
ID4gPiBQbGVhc2UgZHJvcCBtZW50aW9uIG9mIHRoZSBldmIgZnJvbSBhbGwgb2YgdGhlc2UgY29t
bWl0IG1lc3NhZ2VzLg0KPiA+ID4gVGhlDQo+ID4gPiBjb21wYXRpYmxlIGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggdGhlIGV2YiBib2FyZCwgaXQncyBnb2luZyB0byBiZQ0KPiA+ID4gY29tbW9uDQo+
ID4gPiBhY3Jvc3MgYWxsIGJvYXJkcyB1c2luZyBhbiBtdDgxODkuDQo+ID4gPiANCj4gPiA+ID4g
wqAgYXJtNjQ6IGR0czogbWVkaWF0ZWs6IEFkZCBNVDYzMTkgUE1JQyBTdXBwb3J0DQo+ID4gPiA+
IMKgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBhZGQgcHJvcGVydGllcyBmb3IgTVQ2MzU5DQo+ID4g
PiANCj4gPiA+IFdhaXQgYSBtaW51dGUsIHdoYXQgYXJlIHRoZXNlIHR3byBwYXRjaGVzIGV2ZW4g
ZG9pbmcgaW4gdGhpcw0KPiA+ID4gc2VyaWVzDQo+ID4gPiBpbg0KPiA+ID4gdGhlIGZpcnN0IHBs
YWNlLCB3aGVuIGl0IGlzIG90aGVyd2lzZSBhYm91dCB0aGUgbXQ4MTg5Pw0KPiA+IA0KPiA+IG10
ODE4OSBldmIgYm9hcmQgaW5jbHVkZSBtdDYzeHguZHRzaSzCoA0KPiA+IGFuZCB0aGUgZHRzaSBm
aWxlcyBtYXliZSBmb3Igb3RoZXIgYm9hcmRzIGluIHRoZSBmdXR1cmUswqANCj4gPiBpZS4gbXQ4
MTg5LzgxeHggY3VzdG9tL09FTS9PRE0gYm9hcmRzLg0KPiA+IFNob3VsZCBpIHNlcGFyYXRlIHRo
b3NlIHR3byBwYXRjaGVzIGFzIGEgbmV3IHBhdGNoIHNlcmllcyA/DQo+IA0KPiBUaGV5IHNlZW1l
ZCB1bnJlbGF0ZWQgdG8geW91ciBzZXJpZXMgYW5kIHBvb3IgcXVhbGl0eSB0byB0aGUgcG9pbnQN
Cj4gdGhhdA0KPiB0aGV5IGxvb2tlZCBsaWtlIGFuIGFjY2lkZW50YWwgaW5jbHVzaW9ucywgZ2l2
ZW4gdGhlcmUncyBubyBtZW50aW9uDQo+IG9mDQo+IHRoZW0gaW4gdGhlIGNvdmVyIGxldHRlci4g
U2luY2UgdGhleSBkbyBhcHBlYXIgdG8gYmUgcmVsYXRlZCwgc3VyZQ0KPiBrZWVwDQo+IHRoZW0u
IFRoYXQgc2FpZCwgdGhlICJhZGQgcHJvcGVydGllcyBmb3IgTVQ2MzU5IiBwYXRjaCBpcyBpbiBu
ZWVkIG9mDQo+IG1ham9yIHJld29yaywgc28geW91J2xsIGhhdmUgdG8gcmV3b3JrIGl0Lg0KDQpH
b3QgaXQsIHdpbGwgYWRkIG10NjN4eCBpbmZvcm1hdGlvbiBhbmQgcmV3b3JrIG10NjN4eCBkdHNp
IGluIG5leHQNCnZlcnNpb24NCg0KDQoNCg==

