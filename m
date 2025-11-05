Return-Path: <linux-pwm+bounces-7593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4963C34263
	for <lists+linux-pwm@lfdr.de>; Wed, 05 Nov 2025 08:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ED2B4F2151
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Nov 2025 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADEA2D24AB;
	Wed,  5 Nov 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rnYT9ZZP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rtRsBosx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FE2D0C66;
	Wed,  5 Nov 2025 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326426; cv=fail; b=SkadutfnnvM4OfkCj9TlJ27bDKVPzxvPWtbfOcyQBVwCEKzi2R4cLLTwU9NYj/CNyByIjXV3r2lYuf9K2aGreQQlonZzS6oz1z+TItxrvRQQmC1bamt9q1JmiYdKcz8SUoUIShJKl7/bNnqcAzY+p0aVfWbxHC5ZRg3Ztm8nuV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326426; c=relaxed/simple;
	bh=qd/ejtPYACZFT6pZijL4GzNotlHmJWrHph0asaNLSvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMlV6Nxvi4fqikuke2A+oZ8/XyThe+Nlu2DaKcSVyIfkq9tgFd+L2wGYj8jbqWvfXeqeFlKpzgdilRHfUJOm+AMUNQaNUW7CyCYEM+Z5CauuNmxNZd99VWsDl59jfmHIJRZKUvlNVs3GxYMYJhpf5RyHrz8mqF9lgHEh6zuGM54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rnYT9ZZP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rtRsBosx; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 035708daba1611f0b33aeb1e7f16c2b6-20251105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qd/ejtPYACZFT6pZijL4GzNotlHmJWrHph0asaNLSvk=;
	b=rnYT9ZZPCjUAsLWQGj1nbR0N557gy3egb8r4j9LwJ26zwDC7uXfy3KJ/72CCD1NF1KPxI9EYcvvCZX8L4K8huvC1kca9cDsTVc+Sny6K0nJdi0VTP48EWNVzx5rJZ7DuMZfumgyZyiFudxvhMEDuoOYE5NCtiYI3BKH1Zqht4b8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1fe93f86-a2cf-4331-ab01-18d140799e63,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:544df018-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 035708daba1611f0b33aeb1e7f16c2b6-20251105
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1532603648; Wed, 05 Nov 2025 15:06:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 5 Nov 2025 15:06:54 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 5 Nov 2025 15:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiD6p0+Olb5lEaKefPjK6KFfYOGZ7iIQz4wwEwnc4aCom5ibtI85xcZq3/BVsecIxM+g3TYMnSYqcEfTn5S8Qof6lSr4kqpvDOPendQjYD+12+0xXKNHgp4X+f+0bgvZsx5SsXGKgTQvWsFTbliKuv1d7Zyl1WOeK2KCiRDr6LpII8Pl1cl40yw/6tq2352F5eFW29b1CIu5yq+VNAi/X4fYzqNoCUYNkxUlf9l1eq5ARi+3IhWDYraCPLRawjl7YjEyup5V4vvgncdYxpKOFGCnsJhP+Xy5R29RlqK1QA+A5f0fqOPvdrkZ1/Fg6C84lZVa05WbxxpggfmcPKxC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd/ejtPYACZFT6pZijL4GzNotlHmJWrHph0asaNLSvk=;
 b=gaOsxP2MZ7vIA7Qs0L45enspgVNSTZYYXener4rdBgXpK6CzxcI6bkmxTtxiaDuCMd09BYrq2EBTozFtu3Q9pI5W+IWjn/2JS4iXt1ZbPioyCE4FP0LSOiJFxF8u8jT6smJREwytZbAK/z4AljKlS4ICgEQL9yM5chd19DV/y85G7wCFRIeEk9VyUYXc2HHUtfCq8st2gcMpr6tH44P5ojhN6ZGhkqyaFlaghPYLQQTolPJ0SmNbKrvQvg0an+PgP91XTKPzQ1YMBRNJ4iXRlqMsDqz69Txm4Y1FlVfUkPNf4BuAtg/lSxke2EKP41YShgnwd8TogGtgeG+TX5PHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd/ejtPYACZFT6pZijL4GzNotlHmJWrHph0asaNLSvk=;
 b=rtRsBosx1jBQN11cXCtzVAzh9XVGdkcFpEN2n17xwQPVvup3AM5l4tYHqum/M0gt6GZz6SCngL7RaK+uMB0/2qWU+qInqVYTEzV550vI3sH66p8JqFT0RY5dkwDiAtG4b0jnNdKcK0CIuu76YNbKLE9sA310+A0IVoX0pcEV4OA=
Received: from SG2PR03MB6326.apcprd03.prod.outlook.com (2603:1096:4:176::14)
 by JH0PR03MB7927.apcprd03.prod.outlook.com (2603:1096:990:34::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 07:06:50 +0000
Received: from SG2PR03MB6326.apcprd03.prod.outlook.com
 ([fe80::7452:609e:ecaf:7103]) by SG2PR03MB6326.apcprd03.prod.outlook.com
 ([fe80::7452:609e:ecaf:7103%4]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 07:06:50 +0000
From: =?utf-8?B?SmggSHN1ICjoqLHluIzlrZwp?= <Jh.Hsu@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
	<Andrew-CT.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
	<Chunfeng.Yun@mediatek.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	=?utf-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= <Zhiyong.Tao@mediatek.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "andy@kernel.org"
	<andy@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Sean Wang <Sean.Wang@mediatek.com>, =?utf-8?B?TGFsYSBMaW4gKOael+engOiKrCk=?=
	<Lala.Lin@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"srini@kernel.org" <srini@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>
Subject: Re: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Thread-Topic: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Thread-Index: AQHcSaOp1Vthoe3gBUqff+IAb2o1qbTbGTmAgAiZAYA=
Date: Wed, 5 Nov 2025 07:06:50 +0000
Message-ID: <d75decc54a4fc129e5f011cd6e91191896203b48.camel@mediatek.com>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
	 <20251030-deodorant-unglazed-190cbfb4a69b@spud>
In-Reply-To: <20251030-deodorant-unglazed-190cbfb4a69b@spud>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6326:EE_|JH0PR03MB7927:EE_
x-ms-office365-filtering-correlation-id: 84c6067e-3f30-4615-770f-08de1c39e491
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|42112799006|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bmtLbTFrNTBWM2Z2RGh3aHRnd0podzM0NU83QnhsYm1iTktGL2tGeVRuclVG?=
 =?utf-8?B?c0VJQ1ozT1c5T1d2Z0hIUHBkYlpmL2xzRmE4R0xnbVliV3Ercm5GeElIZ1FQ?=
 =?utf-8?B?RS9XM05UckJoclVkZVUxTmNTTjNHWWs0Y0NXbngxUTRMTGtqN3ZVSm16bGE5?=
 =?utf-8?B?R3dJa0FTcGhWdGJUWDVNTE0xamgzTTBkM3UxVmNTOUZpTXZDZUxqY3JBWENZ?=
 =?utf-8?B?NXdqZGplcjI3WVN4YlFZaWpZbkpEeEgvZzBxbDlobkVlYytUTFVKMUhzQk5U?=
 =?utf-8?B?ZU82eVgydjZVbWtjSXlZZjZDQ2MxTFBUUkVSQ3dXVldUK1dkWFRtUm5pd1pj?=
 =?utf-8?B?TzBPeTlWOFZTcG1zQzBXbGJkWlBUVHh4eTZScExWWm4vNkFrazVaN1hoeHZB?=
 =?utf-8?B?TWZwRDZyTE5QdE1DZi82RllidlpMdFYxM2JVUE5EVXFPdDFYSTg0QWc2OEJu?=
 =?utf-8?B?OEU0SHJyYUNzVFZqZUhEWEsyUlhzWWhJbWxKYU9aMHNySzVoYjFIL08wdlVv?=
 =?utf-8?B?bHdiaUpRbG5tRC9ER2oxWi9MOXF0TWt3ZzdjUGM0eGFZbGRQc0FqczMrYlFt?=
 =?utf-8?B?UHg3V1BqNFBwR2hvL01MSHYxcFZrUE5wVndocHZQNUVOSjRGb1IxdTg5OWZJ?=
 =?utf-8?B?Z2lZU0czdFhUUVZKaWJhblhKd0Q5dkRpeWhvOVJUeGV2YktQbDBtSVYwVm5a?=
 =?utf-8?B?dkRSNUkwa2tPc25kTUhGSXFTT0Y2ZFpSQkxNUzFidHZTQXh5aS9RMVREbVJT?=
 =?utf-8?B?cTluNVdFYzhqMVpNTWo3blNINEYzaFRrY0xTU0RuRTd4NDR0cC9oSVpDVDEr?=
 =?utf-8?B?V05NNE5wUmk4QmZiaWtIckMwSm1VVTlMazlWQzNCSklHZ3Y5L3R4cXQ4R1ZO?=
 =?utf-8?B?SUVManpmYk1YMldpcG1CaW5GMXJrbGtsQnl5eUM3ekhVUi9nTE94a0F0Wksy?=
 =?utf-8?B?b252OWZRaTJWeXZkMTJzb2dFeXdTL0V6MWdjNVVtc2psWkRURjArTndweGYw?=
 =?utf-8?B?eVgyT001MWgyRGN4VWdDVExUYlg3eThDWkQ1MmplRERWdWZ6RDRJb29Cd1NU?=
 =?utf-8?B?dVVLZkZkUWh4VmxtUzg5UWFaanB4bDBROENhTGFzaGRiUzZJSVlPdjBJOG1K?=
 =?utf-8?B?V1ViL0JKQUhqRkVtbFNESVZneENCbmszRnkrRDQ5Y1VZVHFTYkpEdG1McDJE?=
 =?utf-8?B?MUZpcFhUUnRXOXRaWWovVmpaYThZMzdvaUxuNnFKa3VIbFZySmZhVUtLa3NM?=
 =?utf-8?B?UXVTUHVwMHNFRmlJM1NjMzhzSkp3QXpKbmUvT3FsbWhTR0kxa2llcE1jbHly?=
 =?utf-8?B?d0dTMG9Wa1Z2cGRxbHN1UEN4SkFuRzNGZ2grSHYyT2REUFN2bVQ1R2dmUTRT?=
 =?utf-8?B?TzZxMWg1ZXpwT2lLemV3bi8zd2Fob3ZhSURvQURpNFdITTQ0K3ZYQUQ0Wk50?=
 =?utf-8?B?QU5acUZuM1lDRnI1VzgxU0xLaFMxclVzZ1hzT1B6Y040OFZ1dFkxVzU0SmpV?=
 =?utf-8?B?aWFpM2dHUGdBSkhzM0dpdlFqVEYrMzFadkpVQnh4L2R3aEV0Yit0QmNIR3pH?=
 =?utf-8?B?RnF1aVVvMFdxZzhLOVVOTWE1NWJ2cHZvSUp5RCtITGxscTQ2VWlXYjFidHlE?=
 =?utf-8?B?MlJhcU1ERlY0VURWMDlCNTZtZnhkUnB0ZzlZdnJHZVZGZ3E3NnpPQ3EwRHNK?=
 =?utf-8?B?VHZseG5DYUhqSWVQWWVOWmFaVWJGZ3dweG9kKzNGbEhTVnd6UnREVjJhaDJx?=
 =?utf-8?B?NkJBMWxka3JUOXliRmhIL1JIcUp5YUR1QWRKUW5JOXlKY25BTlVvNXNZN2lW?=
 =?utf-8?B?T3UySzcwREZEbWF4S25Gem1zbmNiYjFJb1JScytCQm5xNm0zVThGczBqT1px?=
 =?utf-8?B?dWJGelozbjcvaGZqeGgweHVSOWZ0dXN5em1aUU9hcDZMK0xCZzhsL0RncTNZ?=
 =?utf-8?B?R1ZyeXUxaUlzOG9LN0VwYnlXekZUNnNUU01zQVBKdHA1ME11MVZ0N2UrY2NU?=
 =?utf-8?B?SzJINm5XOXZHUlpGR0FBUzdYcks4ZXg0Qld5WFVPWFdRR0ZHOGxDZUtQVjhL?=
 =?utf-8?Q?TLoLqg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6326.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(42112799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUM4TjVKbHZWVStodFNZbDNYcHB3WlZBVGVxcXRFd3VWOUdaVHdRUE1pa1Fj?=
 =?utf-8?B?VVFiS0dYbGpKdEF3eVh2MHZBcU9iZ0QyN0lnU1NiL0ZsV1QwUC95bldYMkp3?=
 =?utf-8?B?ei83RmxWTTBaTk5zeC9hZXoveWYra0JZclVNeGZwQTR2MUpUcnVER2VUWGxS?=
 =?utf-8?B?eDM3MUJjTHhLZmRFTmRrUFNoNWtkbEpxb0ppaUNKaDFWS2dqQ251MjY3RGtz?=
 =?utf-8?B?eEJxcklkVzF1dUpnWHd6MDhCeUxnZHcxNmYySW8zQXBSdTROSndicFJwbEZr?=
 =?utf-8?B?bU1tbzB3enp5TERmZDVBSEh3bEVielo5Nm5IQWVyL0N2VzJ5cHhXS3BkREFD?=
 =?utf-8?B?MldZYWVhWG9nTVZtUk92OWFHcUtybmloOHFsd1RzenpLSFBnTWFCUC84WG9M?=
 =?utf-8?B?TnhCS0NIMnN3VmpYT21vdVh6ZytVZ0xOazFoV0dEZE9rNjJ2aDBGRjdjWmZU?=
 =?utf-8?B?V3dZbEVVR0JHNk9UaXRzVkpoSEdrMDVvVkhPMjV3aU9sYnIzZ3V1cjJPbG9W?=
 =?utf-8?B?bnVOTUFRWmFxQ2xHR2VxdGxEcTdDYS9OSTg1RW11ek5xVDhvQjVYWUlCMjQ2?=
 =?utf-8?B?VXhXdGpIOVAremRPYjNPQWZvYW9WdnhuOXdxY01Od1R1SzBMZW53Z0xiVkh4?=
 =?utf-8?B?L0FmVDZYOUlRUmFSbTB5bXducHh4Q1BldEl5anZTbHFmaEJlVStrMzdWQkVT?=
 =?utf-8?B?b3lmSFpGcExQV1lmK2MwWWJkazRobWs2R0RKdERoTzVzZ3laMnY3VVZzclp1?=
 =?utf-8?B?QXFScU9Lem41S2hPMkdBUG5zSkJlbHFwZktGcmxEamFaRmthSjc3YWNtcmRS?=
 =?utf-8?B?a0llWTRjVjJ1c0VNSHpVVUN3a1JDOFpqUWdCa0loT21VMXJJMDdvdzA3YU5v?=
 =?utf-8?B?YlpLZldjR0RabFNTRTVyL0RWc2VkdDUxM0pRNXcwQWVJQlJhQkZuN2FIOWFP?=
 =?utf-8?B?V0V4bzM4cERNbittRW8vUm1sUjZ6N2h6SDd0QXl1QUhDTERNMjZ2NFo4YW9E?=
 =?utf-8?B?am5wdkpML2ZwbjMrT0dkdjlPdHNNUnI0VnhOM0prU0lCL0kvVkNRK2o0dVg1?=
 =?utf-8?B?QmpudkR1TjNGdUJJZUVocFZlT0t3djZYeWdZd3FsaXVqVEtIdHVvby9VRWc4?=
 =?utf-8?B?QTArZ3VZUWVpV3ZBaStpY2VXM0grUXdDTWxBcVY1eVJldzhab29CY09PcUsr?=
 =?utf-8?B?VnExYWUvOVkwcWgrYWNMVndyUlhMYU5ubUtOcUhMNWw4dU9rdmFYbENTQkJY?=
 =?utf-8?B?OXplTjFxREw5eXlMcVl1ckxTYWdEOUEzNjNHaHBnank1RlVhbU9VeEZBYlFM?=
 =?utf-8?B?blQwMFRqaE1NZTBIWWNUNEs5ZzAyMTZiVHpVRHJmYkpSYi9vb1hsLy9PRnhh?=
 =?utf-8?B?dktFajRnbDJUQ2NFT0Fyd1JwVEExanY5dHFpVFp6eTJSM0djS2ludTVkcGV0?=
 =?utf-8?B?LzRiR01SZlE4dHZJNXpienowUTRGMlk5a3Q4ZVpzRVowS2liRk5hV2lNYTU0?=
 =?utf-8?B?bVFKaWRwbk5VaHppUjZlYjJqOHN2NEY1ZVo0NmdHcnpsK3ZSRVptQldtdjJ5?=
 =?utf-8?B?dEJjUUhCYWU5SnVMeFNINDZWK0dSRjBuUDRTRWNBY2pZTVZta1h2ZUhmcXNK?=
 =?utf-8?B?am9OamJuNTdHT3g1Q3pSbEFiQUFKSW4yWjhVcU5PVm1VNUV5WkQwYmJ1Rit6?=
 =?utf-8?B?RTVxUlZmMDJJbmhGOG9iV3A1Q0kydkU2Uk93aVFFQ3VEVTdRVDhHL2Z2OHpI?=
 =?utf-8?B?Qzhlb2ZVR2VqVk1yampIbXdQb25QWUVGNm1qNDdiRzN1dVFlZE1zb05qVGJz?=
 =?utf-8?B?dE9YbkVITVFSZXk1ZjA1M09PWkg1aVFYdjhXbCtOQmlxRW1kU016TElQaVJR?=
 =?utf-8?B?STM5V1JtUjBjSUNxMG1adGFOT2kvbGlJQUVYYWMyaU5IeVlJbnpQYUVCelNo?=
 =?utf-8?B?byt6ZmJGZnFlWDcwR2I0aVlJSUpweUhCTzlVaEVKSUxRL0wrWHVpWXlBT2RF?=
 =?utf-8?B?UytmMTZJMEM4N1FwbVhSK09YelhKU2IwWGVzbVUzemd2NlVlU1hmTVZlZDQy?=
 =?utf-8?B?U1ZxOVVtVy83Qjh4eTJYVElybU0rNitVYnJIK1E2Q2wyb2NPTldCbGZzU3Aw?=
 =?utf-8?Q?nMSATjXTYN9OyU5h/8S9Noy71?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6DD367AC1C75D49B5E8BD7FFEEF5EBF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6326.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c6067e-3f30-4615-770f-08de1c39e491
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 07:06:50.6039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPTRd+aHtwvbvvDxDqhdo3yGqA705LW2xNBk0FVl6R7Bte0L6OGtkgW+qy8QVSyLBJSb1atZ4dnAL03tL5A/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7927

T24gVGh1LCAyMDI1LTEwLTMwIGF0IDE5OjQ5ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgT2N0IDMwLCAyMDI1IGF0IDA5OjQ0OjMyUE0gKzA4MDAsIEphY2sgSHN1IHdyb3Rl
Og0KPiA+IEluIHRoaXMgcGF0Y2ggc2VyaWVzLCANCj4gPiB3ZSBhZGQgTWVkaWF0ZWsgTVQ4MTg5
IGV2YWx1YXRpb24gYm9hcmQgZHRzLCBkdHNpIGFuZCBNYWtlZmlsZSwNCj4gPiBhbmQgYWxzbyBy
ZWxhdGVkIGR0LWJpbmRpbmcgZG9jdW1lbnRzLg0KPiA+IEphY2sgSHN1ICgxMSk6DQo+ID4gwqAg
ZHQtYmluZGluZ3M6IGFybTogQWRkIGNvbXBhdGlibGUgZm9yIE1lZGlhVGVrIE1UODE4OQ0KPiA+
IMKgIGR0LWJpbmRpbmdzOiBpaW86IGFkYzogU3VwcG9ydCBNZWRpYVRlayBNVDgxODkgZXZiIGJv
YXJkIGF1eGFkYw0KPiA+IMKgIGR0LWJpbmRpbmdzOiBudm1lbTogU3VwcG9ydCBNZWRpYVRlayBN
VDgxODkgZXZiIGJvYXJkIGVmdXNlDQo+ID4gwqAgZHQtYmluZGluZ3M6IHB3bTogU3VwcG9ydCBN
ZWRpYVRlayBNVDgxODkgZXZiIGJvYXJkIGRpc3AtcHdtDQo+ID4gwqAgZHQtYmluZGluZ3M6IHNl
cmlhbDogU3VwcG9ydCBNZWRpYVRlayBNVDgxODkgZXZiIGJvYXJkIHVhcnQNCj4gPiDCoCBkdC1i
aW5kaW5nczogdGltZXI6IFN1cHBvcnQgTWVkaWFUZWsgTVQ4MTg5IGV2YiBib2FyZCB0aW1lcg0K
PiA+IMKgIGR0LWJpbmRpbmdzOiB1c2I6IFN1cHBvcnQgTWVkaWFUZWsgTVQ4MTg5IGV2YiBib2Fy
ZCB4aGNpDQo+ID4gwqAgZHQtYmluZGluZ3M6IHdhdGNoZG9nOiBTdXBwb3J0IE1lZGlhVGVrIE1U
ODE4OSBldmIgYm9hcmQgd2R0DQo+IA0KPiBQbGVhc2UgZHJvcCBtZW50aW9uIG9mIHRoZSBldmIg
ZnJvbSBhbGwgb2YgdGhlc2UgY29tbWl0IG1lc3NhZ2VzLiBUaGUNCj4gY29tcGF0aWJsZSBoYXMg
bm90aGluZyB0byBkbyB3aXRoIHRoZSBldmIgYm9hcmQsIGl0J3MgZ29pbmcgdG8gYmUNCj4gY29t
bW9uDQo+IGFjcm9zcyBhbGwgYm9hcmRzIHVzaW5nIGFuIG10ODE4OS4NCj4gDQo+ID4gwqAgYXJt
NjQ6IGR0czogbWVkaWF0ZWs6IEFkZCBNVDYzMTkgUE1JQyBTdXBwb3J0DQo+ID4gwqAgYXJtNjQ6
IGR0czogbWVkaWF0ZWs6IGFkZCBwcm9wZXJ0aWVzIGZvciBNVDYzNTkNCj4gDQo+IFdhaXQgYSBt
aW51dGUsIHdoYXQgYXJlIHRoZXNlIHR3byBwYXRjaGVzIGV2ZW4gZG9pbmcgaW4gdGhpcyBzZXJp
ZXMNCj4gaW4NCj4gdGhlIGZpcnN0IHBsYWNlLCB3aGVuIGl0IGlzIG90aGVyd2lzZSBhYm91dCB0
aGUgbXQ4MTg5Pw0KbXQ4MTg5IGV2YiBib2FyZCBpbmNsdWRlIG10NjN4eC5kdHNpLMKgDQphbmQg
dGhlIGR0c2kgZmlsZXMgbWF5YmUgZm9yIG90aGVyIGJvYXJkcyBpbiB0aGUgZnV0dXJlLMKgDQpp
ZS4gbXQ4MTg5LzgxeHggY3VzdG9tL09FTS9PRE0gYm9hcmRzLg0KU2hvdWxkIGkgc2VwYXJhdGUg
dGhvc2UgdHdvIHBhdGNoZXMgYXMgYSBuZXcgcGF0Y2ggc2VyaWVzID8NCg0KDQoNCg0K

