Return-Path: <linux-pwm+bounces-3189-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588A973BCE
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102581F27E8E
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA81A38F9;
	Tue, 10 Sep 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADA6k/Z1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013055.outbound.protection.outlook.com [52.101.67.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58D199929;
	Tue, 10 Sep 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981919; cv=fail; b=OiufVZ0pboj1vhL/Df8Ga1qs913nv7cg6wVWyhpvDN1jD71UrrgnDAkTsfNKDc0Eqjmop2GGp7nqOlms0VEHNbfyb1sKdVQYJwjFIbzx8RaXu67rBdFAGlVzQwhRwwHg2nZhm+Hl8R84zFQ/F1WXvO5iZkhbkX19itcNSnsrPTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981919; c=relaxed/simple;
	bh=H0AaA0v44wjGMn9Z5TJRIGEjSf55BVhlQMQWKo5fhPY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tq+VBiiAoOLYwKczUzcfWBa2Qgjwj69W19QoHn74Uvi8kHVEQefAnc/VLDDKsmsNZROARGXK3yzkqYE5nDkLTEpJ/k+oCeBshA3fNup9Vmyehf9pskv5mJzdiVMKTY0mnjz3Mia0wc/u8i7gAOrzboMoNoJIkWIPdwVeYztZ3Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ADA6k/Z1; arc=fail smtp.client-ip=52.101.67.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vuudn8LSipgEr0RoeNfQOkiAoOOI9L00m33i7mmaMVRd+4nBUikYwJ7nNXGnIjwjEHl5QTwjq9n3jPlHXOdWvdREQet9LF3p4i8RzzeTjw39Zk0YqvWXy506fNUYsQQm5zO8edw2tnKi3lvXtsgxqEZXjXAZT3H7lpypSC9N6hrU/XtIp0rcCllpGye/N49YmEPW/5OtT+OhfYqqU1G6jwIIazQMT/3ZcKiPyH+KhbTha3P61a/sL/r8yNReMMzuJ20/Dt3TF90dGonr7J/Ij8OFo43ZzgK65YbE9Dl37RTRBzQA5Rsr33NSAz+Y/4/zwrekDhTjUKIhK+Oydv+Vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IBCqWIcx2ffUrxwzEvi3NnNp8Hmo35KQF6jfIl7GjQ=;
 b=uV9a8oayQ3NNdTPeMW0FGQITxYP61U+Q8GVjonz8eQxzT6ZdDA7d2HqZuqn1Ck2ZMAErotpwJIiD7vd3OwWA9u7dmgM5+Z/TakXU2YXRfWTcti3ockPHBWl+FQHu31LFTmNH1vUYkMo6OkrY3wKx4pHe0a/FQCCVgb8Y3wXBFhGWc1hQeSzNUxjeV/xn6D8PC62hTWGzpPvG3jnwHGmxYtkTCeyVhNPgI+o8IIIZ/xO3h1fKCS8aELONmyp3BSJ6YIvd+vm4xCgFwthvyxfIhJOhZPnXBa5fXss/oE5+92yLV1eR8qykj8rbyKa5ZMDwX+kHRMNmlsf66C74rYO+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IBCqWIcx2ffUrxwzEvi3NnNp8Hmo35KQF6jfIl7GjQ=;
 b=ADA6k/Z1Yd1gewHqffLnNL2AJdtGZP4gqOz+C9d+RYHdevyuXWLHZVqpDb20fGEZQMVg8nwI4WmP3T6cO5BLMuWNPBx+L9Y77QuPQawFBUsDAzI0UEEjOi0WMGPMNB+3RV6nlvpz61R4yfHTSHz1zDJK6+z2XV6daavvTLC0w6UNcoFwbwHskols5DITZjCfRXb4x2eDAoa/h76d0hEplrHcQmWxbfU7uazzd4+dLJtf3QlFNLrps1yINmlUXLMTA/D/m+eGII9UGmzJFpN43h6OP+eqjcQMCwZEnLkpa/gS+UFzxVbycq+SpBbimRBYuVK22Id/DDceRLgPVLUt9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8764.eurprd04.prod.outlook.com (2603:10a6:20b:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 15:25:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:25:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: marex@denx.de
Cc: Frank.Li@nxp.com,
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
Subject: [PATCH v5 1/1] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date: Tue, 10 Sep 2024 11:24:55 -0400
Message-Id: <20240910152455.2425152-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb6ad1d-1ea3-44f2-e24a-08dcd1acc43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkU5NVk3ZGZEbFJLWitUU2ErbFh1RUNxdkV6L3diTmVZTkFtTjE5MGxGZE9q?=
 =?utf-8?B?NlIyd3BMTGZKNmxlZ1BLTmtvaXVFUURpODZXeDcxd1Mwc2gxK2RYeVNWS2hH?=
 =?utf-8?B?VE5McG9DaGhrU1A1U0pGeEU3NFI1YWZRSlB6aU81bklHYjlrazZYaU9vN1pj?=
 =?utf-8?B?bG9IMmJqOTlZSmZBR05wbWlXOVBuanJPYWIyenF6WG1qN3hxY0RoQi9ma0tv?=
 =?utf-8?B?MUNOdXV1N29QelRNNmVYSEpDVkV4S0xUbmNNV3NHK2tZQ2FhbmFCSDFyN244?=
 =?utf-8?B?L0xDbysvNXZ6RkVIZFhpTmtoNG13bFFZdTJwTDdYM1BEMnU3UjZoK2ZFVTRD?=
 =?utf-8?B?TmluUGtkZDJ2Rkl0eG53T3NPZzJSRnJYTmtCdFBtK2htOExaTHQzOWtQcFdR?=
 =?utf-8?B?Ulc3ZXladVJYOXhBS1oxdHZQYzh6TDYyeVliNnVxek5kT1lxaG0yUUxIVHlG?=
 =?utf-8?B?MmdmNVl4R3A2a1dKbzN2bkgrK09IOVlWTTdhSi9ZaCs0dWhlTVJtR2VPNGpa?=
 =?utf-8?B?WE94Y1NzRmlZNTFLV3VXZlA4SUlPK1VjYnhQWDhqVnVMODU4WXVBRVovOERM?=
 =?utf-8?B?QjRXc0FwOWJkSTFWNFpCdEFocDFGMEdPZmkwTnRUMDAvb0trd1Z4S2VtMHY0?=
 =?utf-8?B?dVlvRkRsS1JyV2w4eFJFUlYxVnRnZy9UVFZMdERjQ2UwWGRaM25mODhsMXBH?=
 =?utf-8?B?U3VKWnNmR3VBTW5HK0VNQWdKRngrT3JoZ3RKcjM0R3AyRTJ6VXgwN3U4b09H?=
 =?utf-8?B?SThRalhhMlJsTndCelBEMkV0Ulo1SVZtZHlVbE1hcjBOb044bTUvcnBJKzUr?=
 =?utf-8?B?eHZGZzJmQTVGUWRHOVhtS2x5QTM1YXpTeGl3TTg2eUNMNGNUa1hNMkZrTks3?=
 =?utf-8?B?bGhFSHI4ZEx2TnplUWlJYU9CZHRxbTlHSTNGaStKcy9UaXpWdjMzSWdKeXk1?=
 =?utf-8?B?emxHaVhaRjVWWFB3clk5d2VCdGt6RGxUVW5uSksrZDFKdlRqbVl5RlBqeGhs?=
 =?utf-8?B?SVQyQ1Jhcm4rR3RkWlRWdldGVklUL09tRXZESXJkVzkySWd6dkdqZi9kVHVN?=
 =?utf-8?B?d1dvOGJjb2JwU3hDRHJpTGhGRnRBeVhDRXpYMzQycDRPYVU3Y0xVUjVZSjNh?=
 =?utf-8?B?U3Z4SndMUzM1bFdnVm95d3lsdGx3NjQrR2swZnhZRlFLaTlWSG1hRktTN2FW?=
 =?utf-8?B?M2J5amdSMXN2SDdBSm44VEhXNDUvTmk2R0hjYWtUMU5MTitCR3FmWDJtQ1NU?=
 =?utf-8?B?MGJON2FNazY2SjNSKzNQZmRHZmN0NXErVERjalVabE5FckNoakhwNjJuMytm?=
 =?utf-8?B?SldPRTl5dmxFVFMweWR0NlovOHlvZWFaSURCa3hlTVRqY2lDbThhdFJ1S3R1?=
 =?utf-8?B?SUZKUU5kcWpSSkhVdklNRkZpSDIzbkxUZ1drbEVha2MydFo5aXMrU3Y4T0JQ?=
 =?utf-8?B?c2Y4a0owMjRUNElBbFA3SGJQQXk4TmpaelUyRlY0QkZRcUh0ek1ZTGx5aXFZ?=
 =?utf-8?B?YzNZR0hxSnFrRnRUckg1UGwyNnZWczZGV3FHTjZXU3pJNlJhdURERWc0RlBM?=
 =?utf-8?B?M1pDY29qME5ZZXBhRWErWUJKbFd6OGRhcWlNSDczYjBGeFkxVlNhZ21DaThW?=
 =?utf-8?B?SSt6NkV3YVp6UGNKY2dMRHNMdXhCSHdTd3RZdEYvWXRzam5IMnYrei94SFYz?=
 =?utf-8?B?a1daZlVBTVJEM0NqTTZoRW5KRFFSY2djYTJxSVllQTVPT3lLRVNCMVNmOUt0?=
 =?utf-8?B?anhjaHVidXhXUStvWHBMUG9zUXZCMWllK0RNbmFuUW1ZUTI3RzIxUE1YRXQr?=
 =?utf-8?B?eUI4T1Z6K3NncHhnOWkzV28rRFZGM1pyOFpMc3RSZEt6alQ5NWxob1dZWnFm?=
 =?utf-8?B?dFZrNThTNW9qQS9lQVp4eDA4TVd6T0FpTWg3dDNVL1FwbkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVnRjd0WGZlT3dtb0ZPQk1GdHNNSjdQYVJLLzUvK0lvYVB5bHZxSWs0YmNN?=
 =?utf-8?B?WWkxYjYrdWFSS2FTUUlKV1hmWEhuM1FQb0w1c0FFSjJvOUdXeDFpemxYeXp5?=
 =?utf-8?B?SENIRzcxYjVnVDF5dVhjejZoaGp5UjdHR2JGYWMrRHBvMVJmTnVEU3BXUGYz?=
 =?utf-8?B?UktwMVkxNVNOZ2t4UUZ0dklmMDdaNDRkakpLa2FZaU1ka0FORkw3cnhOdVpJ?=
 =?utf-8?B?Vm8xSG5uR0s5bjR0Y2lYQmdBQWE1Q21hOHE4WVRhcFFlbGw3TWxJOTZXbWlo?=
 =?utf-8?B?ek9mbmRTMFNESW5scTcwWlZHZ29jSGtNREpXSEhUclNKbFJKOXpYaFIra1ZK?=
 =?utf-8?B?NW4ySXp3TDNDOVB1RGRHdFhPcWE4N2ZuampyNTkvenZFbXRveTU3S3FMUTdV?=
 =?utf-8?B?bWU3clIweGJXZHV4QTIyTEF4dm92YjczVzVTMTEzU3c5ZVlUL08zUTRGM01p?=
 =?utf-8?B?ekVxazQzTERvY01NQ0NMQ1NlaEFMK1hJNVc2Ylk4TjRSN2dGVUg0d3B5d21o?=
 =?utf-8?B?Mis1c0lmSnJCanZIYkNWdHloanNWeWVyNWlscGh0WmFpSlFKaFNJRVRVZVFV?=
 =?utf-8?B?ZWltYVYvdWhwNWJmRUUwL1ZOYW5lTFFRTmE0cG5mT2dNVWRXZ2ZpNzYwUExx?=
 =?utf-8?B?Y1hTZ1FXR0RpSFZBZXdWWmRwUm1JSzIxVGpqUUcyYXEzdDhIVXpWN3hPU0R4?=
 =?utf-8?B?c1NBOEl2RG1OM0ptdFpUUDJ1NUxRWmk1RE5KTGJ1SUVVd3ZuL2gwakczVFFK?=
 =?utf-8?B?Ty95OUcrOGEzUytUK0FNSVhxa2ZyQU9LVCt3SitYMC9TWW96YlNZbHJkUzlV?=
 =?utf-8?B?U0RJYWZubGNHdmxUcHVrMXMzbzIzRGtRQmJsSzZQdytyQm1RY2ZITnRzZHNW?=
 =?utf-8?B?ZXpsMUsyazMraFk4cE5nbzVCSUdqaEJmSWEyZ3lobjNrbDFTMldxVVFCZ3Jh?=
 =?utf-8?B?b2s0SHR5UnA5Mk80WW9Ra3RrQ1Y4RFJ2amU4cC9YTHkyMTkwSE5jNGEyZUpr?=
 =?utf-8?B?SmVJbjl3eGhFTktFRzJpMDdEYU5SMFhvTHorNTF6OXlQWlBKcjRQRkpwdVBR?=
 =?utf-8?B?UjJnRUFnR2tUV1hnSmlqNUgyNUpiek1RVXRUQSthcWF6eXY4M2V4UTd5bTVx?=
 =?utf-8?B?aGhnWUpJTWxFZTZQeWlNKy9xRDAzWitXZm5wdU8xb2d3bjliWHJncWxqeThG?=
 =?utf-8?B?eGNWM0xoNEhjQmxRaUppV0pSYkc0YW1EMDVwL2krMUR4UXNwMEoxWTFMeElW?=
 =?utf-8?B?K0R2REN5L2RSMnlZejVCRTNBd2tLT2l3YjZXZFV0Z3FJZitmL1hUY2liRGtt?=
 =?utf-8?B?TDNIUVhWMnRsNG5xNG5wTENjdlhKTmpyeVJRODF5b3Ixd0VDcDFmMytFY1pH?=
 =?utf-8?B?R2tJcmM0MTNuaGJQWm8rQlNvS2RRUFljeUNsVi9UOXpOMkVKSUw5blQyQkox?=
 =?utf-8?B?T1I5ZXY4aUI3Y3FhRjFtQTJBNE4xS0kyaUNVSENwOFdoeUs5ZFphcjFJR0FB?=
 =?utf-8?B?YVhrS3p2dW1GanRDMUIwclNuSDhwaHdiSExGZjJaQmxMSGw0dUlsa1JQWVVz?=
 =?utf-8?B?RmJMTU9IT2czU001T29EK3N1Sk12WWpNczhBK1VVRjVHdmlnZlJUU0Y0U0dx?=
 =?utf-8?B?bGtRWFcyN1pHQjdTZlJURE9tVzFZbnUzcXJraVlNTHdnalhCTU81Q2FIeUtL?=
 =?utf-8?B?ZXQ0WlJGTDVDdUpDZmtCRzFINjFVNXVNSkgveFA3Y3k4SFJNUml1bUVwNE9H?=
 =?utf-8?B?Qjc2aWxjdDR2SkhDQkdzTmw0ZXd2RmFIaTlxbXNBZEhPekJJcEtpTFc4QjN5?=
 =?utf-8?B?V0ZnTGc4cW84V2c0aEE0V0x3OXVIS3VJSnpCUExMdzZTcFQvY1NvdU9VSGI1?=
 =?utf-8?B?dlYzVGNhOW90RHREOU9RMlZxckFoYy9JMDVIUUd1MEszOTNMc3hBbktlL2xE?=
 =?utf-8?B?TGdZWTdmZEZjTWY2WXFNd0tUVHE0WlJhb1dDclIxNkU0bDVtcmVYS1VQU25o?=
 =?utf-8?B?U25OR2ZyQ1lucVlIdENacHVMUGRVd2lOOVVhWThST1lQSGRMN0R0ZEJLRDFt?=
 =?utf-8?B?bDlXSmloczRmN1lkb3ZOWEFraVRKQm83Qzh0L2JLSVJ5MHB2MUJ2aTFqZ1pL?=
 =?utf-8?Q?RSCIKbunzYjOjj4YGLQOJr+D3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb6ad1d-1ea3-44f2-e24a-08dcd1acc43c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:25:13.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjGSczM3xpZka12oRRf168bfNwT0evK8Q6MhM1rBIHO4Nkmr5qUMBqYQn0dvLOBWAiEMLUTXY76VVqlqXeuKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8764

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
(or <500KHz) because write register is not quick enough when PWM period is
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
 drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 253afe94c4776..713d368f03931 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -27,6 +27,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -234,6 +235,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -274,7 +277,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	 * Check new sar less than old sar and current counter is in errata
+	 * windows, write extra old sar into FIFO and new sar will effect at
+	 * next period.
+	 *
+	 * Sometime period is quite long, such as over 1 second. If add old sar
+	 * into FIFO unconditional, new sar have to wait for next period. It
+	 * may be too long.
+	 *
+	 * Turn off the interrupt to ensure that not irq and schedule happen
+	 * during above operations. If any irq and schedule happen, counter
+	 * in PWM will be out of data and take wrong action.
+	 *
+	 * Add a safety margin 1.5us because it needs some time to complete
+	 * IO write.
+	 *
+	 * Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest pwm frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500KHz), this workaround
+	 * can solve this problem. No software workaround is available if PWM
+	 * period is shorter than IO write.
+	 */
+	c = clkrate * 1500;
+	do_div(c, NSEC_PER_SEC);
+
+	local_irq_save(flags);
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
+		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
+		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
+		    /*
+		     * If counter is close to period, controller may roll over
+		     * when next IO write.
+		     */
+		    val + c >= period_cycles)
+			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+	}
+	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	local_irq_restore(flags);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
-- 
2.34.1


