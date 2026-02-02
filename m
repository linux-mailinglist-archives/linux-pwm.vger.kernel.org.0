Return-Path: <linux-pwm+bounces-8027-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJPnGdOAgGnE8wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8027-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 02 Feb 2026 11:47:47 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD4CB2D3
	for <lists+linux-pwm@lfdr.de>; Mon, 02 Feb 2026 11:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5595E3004DFF
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Feb 2026 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FCC357737;
	Mon,  2 Feb 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jJvxZQj7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3D285418;
	Mon,  2 Feb 2026 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029265; cv=fail; b=OH2NwqCIQTI/iig95GhJAiaCGTIrPsyFqPNTgO7ADBWp6Trd1Ndg1D9kOfZ8jClb2s9P0/8HZfEQFUXXubowJqix6PD1gdy7P9TzeNXwG+xbfX+goBPD0FP0MIcxJE36aZBY+e+wmdaCzLkOvS6BUaKVQTaTmt2yzYsJuP/Fkbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029265; c=relaxed/simple;
	bh=4gLYn7PF5aiWOg7HUtL7U64fbiop4qeyFHo/Nq+kw34=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fG47iac6gGFeQEFzSb9ESXc8P72YF/2Fwm7jJ1NLEzdYGZhTUduanVEIRER3pLMyjT3eQDniGKaZC6K+ZGIPaDHT/bCxiMHTCSiZOSd5o3TSfVWZoI+URWo5xWZGBv6yJVBYPcr+P1R74iJ9J4+zSShEzPtBHoPm66dflSP4+EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jJvxZQj7; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUSqCs6q9eFbYRZIotsUghApPnbhOao9c08xyNu5wQUqVSWlNnV/hLeKpYSurLraUqV/XKPEUky0bWaNdTG68q20Mo1dnaBfC2LzQQeqQ4bUCAdzG6tHo/Gr+BUhUDkdDbgysvYYTcEWXM7rPhn0AX7R8Jf198fKRHa9DDtMq1fTnK/FqkGB6WueUnLTDdtO81Fge2ivb6QfIxQ9E9al2qZf8b34/vpMi0oThHLRqiuF3in/1x9WartAUKyU+lILMSJTbICd4ZX6Sp9i+yega/WvQbaxyOY+jvxblSgYd3wVn9mVvTV/JyTGh0DoMYsNlhRaRci/bQd45S+gKMmUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWlyQCYCPH6dw1BnOGtZqpK4ltO01fWOyZbVcWzGQQ8=;
 b=pS53GwfFvVpkCWFs4QdY+pHIXgOR70A0E5PsP+nTwOhx08wp4v3ChdRW755G3+1bWbUPx3Xp9lGEh10N1Myma6ZOdUaPFYlNLROs/LjAoNXtJs1+wJB7iZ1+ECRPQl0UoN3N3gqtqFwuMgLSHX5R11/iQvFRQZFBS6QJ457QcwG7F/rFFxK8+59Vkvm4qEF0pbR8Hxx+0D/oMGmuJWo43+hEt7W5RjPmuErdd54Xl0LSKmWHsXogGHcNcNfdIg9n5rnul1o8vNBXew2BvcQVYNNk8VNgw5piUwT6IGN5XY3yPqzhEvyZtFghlFlioBqf3lLoF4BhOCYmdKljxx8APQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWlyQCYCPH6dw1BnOGtZqpK4ltO01fWOyZbVcWzGQQ8=;
 b=jJvxZQj7qI0R2WUPl9WexgNKVdBI0Ymn556Z8wC4aGN8fSLXV+lYyUWw/Cep3gPR0pnuRZSlcofhPZPSj1xEm3+C20Mpbn1lEfzSgT/xQUTyXWx/F2Z2gdt8REDp/ERL81HgsZ0Mj3Ek7o6Wu0VN5Jet/ZIzM0r8fDnnJeBnh5qof9wda2t1zvPWMwk2D2/PVpewmlJCGasbrzfJ1chvWFUQJjGNYCrWpImuXzRF8Kh47RFAUXrkGZx4K2uLdtVv+r2m8EvWJy/DKCkVmiCWXroyNrXdUQYIEG59fMp1paZVUsOux3EKog+o4F2i9jG92Rdxmz2cQCMCM/1B8wmmAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5112.eurprd04.prod.outlook.com (2603:10a6:20b:10::30)
 by DB9PR04MB9282.eurprd04.prod.outlook.com (2603:10a6:10:36e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 2 Feb
 2026 10:47:40 +0000
Received: from AM6PR04MB5112.eurprd04.prod.outlook.com
 ([fe80::a348:65cc:67d4:1fd7]) by AM6PR04MB5112.eurprd04.prod.outlook.com
 ([fe80::a348:65cc:67d4:1fd7%6]) with mapi id 15.20.9564.010; Mon, 2 Feb 2026
 10:47:39 +0000
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v2] pwm: imx-tpm: keep channel state instead of counting
Date: Mon,  2 Feb 2026 12:47:38 +0200
Message-Id: <20260202104738.837016-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::18) To AM6PR04MB5112.eurprd04.prod.outlook.com
 (2603:10a6:20b:10::30)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5112:EE_|DB9PR04MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b4a5ec-4c62-4279-b05f-08de62487c6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?OfZEJv8wll4S3JkHPPD+2xM31i7g3RlxpKyimkJaKrd1e03RuoAXel5UBU?=
 =?iso-8859-1?Q?2Y8Mt/r7IHGhgoBJVWhACNnwHKy1Hf5V6tkh4CJuvHuWoEBBfvHKKNihVF?=
 =?iso-8859-1?Q?at6Fexbl668Gi30ST2ZLCN6W/XThdTLHEmeuCwJmUET/2HnsDvLn6o6nB2?=
 =?iso-8859-1?Q?wAMLhxkYMRT86oYfqU1YThHaEl7ns4x6ZAtzeNdb8iZf+Pi7KVYqdnlMME?=
 =?iso-8859-1?Q?hv16XPSu1hffkGMPiVx9I/F9wUeqX7afnj5LzA0kvWGcPujIurWoVRue1y?=
 =?iso-8859-1?Q?5UjFyucr6W7RQI/qLwRLRMPL5nB26OUsAsQ9DaiLfyQ2W5zepLVhMAY3H1?=
 =?iso-8859-1?Q?WkrLVVlAbx/cfjr1iKer+EjCLhsd/A8UQDkluUddGkxIkpv14bhE0JwJ8+?=
 =?iso-8859-1?Q?rgaIKTENaE3iIj65QxoEKut9dhYuDKWNMJun8mooG2hMZjermTBYFlmv9g?=
 =?iso-8859-1?Q?GAo+ETU43phbDXIZyjYhR0E8Hh+XshhNTgcZx307AOQwv1h49/51zq+lp/?=
 =?iso-8859-1?Q?A+cglZBa+GcMkoO3F0jslp7wmCviphwulbwRQqljUFkhELvhlXuJ8kghdv?=
 =?iso-8859-1?Q?w48DnVUBqleIT3i+/YHS3SFPmbFJX/Yey8NkOYWrtjN88v8Tvg4T/5+Zbk?=
 =?iso-8859-1?Q?K9qmyjf5q4GSTZKQkvYXs+UdxB55P8jr1yRKqxzwZyD1JUg52M7KxahWki?=
 =?iso-8859-1?Q?D7zz592TH1J/WbrC0nLfg5j4HzqBmY8vG9efTgeWDq3q3+MJqa5kGEXIy3?=
 =?iso-8859-1?Q?3QVarg2VVUOuyispi6edE0Ob24cLgi+IhczKkDS+bNi8oRbhPsOndu6Cs9?=
 =?iso-8859-1?Q?f2G7iqrc+C8RtjNDx33jfJt3PaxS5Tx73uX5tgAlrv0S05uX8A2v3CCCra?=
 =?iso-8859-1?Q?Ot0Lcfj1aEEvcEdJQRpK/jvRq2WDycTciNWmhjoBoamqIL61JUCAd5dz8N?=
 =?iso-8859-1?Q?ebt49drlY1cGkP7yWyDAJ3aUOSWHQL33zWrBFrHE1K/88+P7gwZX/gTp58?=
 =?iso-8859-1?Q?PA62Xf2WCWR0U/LAKxE3Ki0t4aMGpO49PIShVMXLtb4gS3W6cDsQVS5PET?=
 =?iso-8859-1?Q?q/IFWneXtww0UZt+wreGcw9MggTmX+SSHF29qSMTxF9LnpUsSsL/mUCiE9?=
 =?iso-8859-1?Q?z5cCiZ7sLwp+YWpEbV9gVvw70kdkF85YOHh6HCiSDqRfoc3anWkZU7yJAh?=
 =?iso-8859-1?Q?tMPOcd1p/EhgrVStW5CCeGsZ0n3EFqukZoL99WXLLwoY3M3Bhoks8sQgjz?=
 =?iso-8859-1?Q?z9w0z5+X1tZ/LtG5wVHWoU9vVIOY1gxfAlzM8JvS/PC/bcpiRjMAmKpWBS?=
 =?iso-8859-1?Q?xJcmlVoEcrPYX0ejpEeC7W9A+VOi55dPyX34cVOednIMnA+zXRsOvne3Ph?=
 =?iso-8859-1?Q?/WomkalXZ42C5tsQBaLa+xmgvC9KZuO9vaA3h9gMCe3FCzAPdyOsxxVg4n?=
 =?iso-8859-1?Q?AduZPRwAVU2MX2H/ghMtPwe8cSD+oZJZvwmZcpOR+zqNgDsof2MbuZBr/j?=
 =?iso-8859-1?Q?aCFqDJplAeQBJkp+Epg2xPdsxxz48ThDvg1raPLHqYsSyGF5NUYhBNor6p?=
 =?iso-8859-1?Q?l3bUJ44zj3dtuLd0ulVenJnoOvdP5Z7GvdS0i2q5JQ+wapqy/cHQRgcQlM?=
 =?iso-8859-1?Q?sreT3wIM7SnGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5112.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?gliW3qx1ntx0sNNFEWfMwPpjZber9kfd5W1QDR5uC1/dq/KiCmeZKLuMNq?=
 =?iso-8859-1?Q?uFKMOMYd15WEd13WPAeFl89Bvmaomfa2niG6mdtYKbYuyby0UpfqHYxOxc?=
 =?iso-8859-1?Q?y61mtScPL8km0R3rJgH6uJAa1Pv7Lj2K8VFYnH42XBr+SrZUUZBTL6wwVZ?=
 =?iso-8859-1?Q?KyRxHvZm+8pZ19j8YEV/ckIgsmlCPNeVw2dzEfxZdm68hnB2Vtcgh2HnC/?=
 =?iso-8859-1?Q?+0kLEW0RHR8CFTTS/o9zlaUG8GVEGqHs9V0XRvkm5Hy3kLJk6UvTlrz7zi?=
 =?iso-8859-1?Q?Gu3ilJJdUkgglWoEVcR5vAeyOSXJ5o75704vMsc/ZPa+b+k/uGg1PgyGXl?=
 =?iso-8859-1?Q?uoCUC0Y9g9R5SkJg7QC5i4a0mYoa4vhw55WrCXuCzTFH2pIe595ctT6oYn?=
 =?iso-8859-1?Q?ELVKc6kwK+XbFRzwvy0SYnnkwzMK+/5p8G0WgvgXZbuyG9XowX4RUvfTJI?=
 =?iso-8859-1?Q?38W9qUvFYZKzfidJ5BsOi2jwpjtyintoaSAhIi2yIYpprUGQbj0kAhdIiz?=
 =?iso-8859-1?Q?0THOaOOoS7HndIGMt8Ul/zm5kZkn5PGuLzw1uohb+gpHGfQoQ6Kz/m9xsW?=
 =?iso-8859-1?Q?52CVx6k310DuJtiyEYWKHNDr/obXApCZXl6dEYGlmaYRMlbRKqRZ9Dh9q/?=
 =?iso-8859-1?Q?RaW1GuVPgFRobS0Y1C1imjHj6kC5yO/tuv71F3Tp1VCAX4e2+yD7zc1QKb?=
 =?iso-8859-1?Q?5QOOFS+KJyawr3ChZJuhXxsS/w2gkfJjJ24aqwKq0nsi8fjJVviy9K/GGi?=
 =?iso-8859-1?Q?1If/pF6GLyAlh45UJIVNIczYeB9H8sS0EHKrFrH+sK+q7hoEBPiUOktfvg?=
 =?iso-8859-1?Q?5tDyh2hRJ0BWBPwlxEt04cAA/pKSUH1VA47xF9E9zBe9hWfqyPb/m2Neh2?=
 =?iso-8859-1?Q?ld6ErspC/Kz3u5HOWxHHljEvwTZbrBxRVpptI4pN5ktbGOCX+HfFpiuJct?=
 =?iso-8859-1?Q?5GHUv0ravlF1QO5euJSrgEZKcNzfwul+jojtvJlNT8fWijJ73vshkdNHdb?=
 =?iso-8859-1?Q?JsYxKt+hDT6wjZ3hTLtQUVgiPkhG6AlopfES286La7fPD7NNglNb8gzsat?=
 =?iso-8859-1?Q?HzGmtGF8nlGAtuUxcY7abLxzvluA16OQcRxG69ow6HXU9yjQF8JCB5Uh9C?=
 =?iso-8859-1?Q?nF/i9sR72ssNihlgqt0ZQ9E+iLaO3zrv2o5Olq6sewYuxKBk87VIX1hgZd?=
 =?iso-8859-1?Q?GaDHcgkcRxQBd1RvCyYvWTrTnP13j4EMsQ5UeRZVzOdQl/4orUX9Afjncz?=
 =?iso-8859-1?Q?kws0HO96hrgtoKKYOGMgOOr3jBLKP1dBrLAhtG/5Xz0Xut4NEdOgmjRfuU?=
 =?iso-8859-1?Q?ivQV/o4ahaOSYUuuOpjVBZTAOZ5m57B6kgvwoki74drrCjhJQM9FEVC1Bd?=
 =?iso-8859-1?Q?xbGLCTc5yAqfFfFDy5TcPUPVDhKVLq43XmrnIAzQUzN7C+5JvWukXRsIgK?=
 =?iso-8859-1?Q?kAzUgRrHj4CWiD5EPLNGAXWDRqzqw+DQxfgo5PSkMLo7ZF/34sV+CmIwFV?=
 =?iso-8859-1?Q?WgZEdt6cE+as+gOOMcb3xk9GfVs1oZTkEsNIC/2ovg5nK0aosGsDb2xEz8?=
 =?iso-8859-1?Q?yViWVHFDeqrWzi673biDlsBza8lG64Jv81EW/yUreRAcsrtQ5K9idct434?=
 =?iso-8859-1?Q?DUsfLA7/63Eu5v7wVM/C3/mMLd6LoO3h4dM87ibmDD5gJoVIKz/MV90tpo?=
 =?iso-8859-1?Q?MX1pxIJ8GkhWqDJJHitaUGf/Y8Rb74seid5rYGwyDYoPzL2H1dCBriAOyV?=
 =?iso-8859-1?Q?MqbcF1/moYOLYeCZxcvnTPIOi3i5CM3WqvIC/lkqx45nRKvKW5x6qI2q07?=
 =?iso-8859-1?Q?RK2ZIN2Rpg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b4a5ec-4c62-4279-b05f-08de62487c6c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5112.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 10:47:39.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FeKWYY8zzdlAVR+ulRYV8tzo46ANS9/PwWLeeBuG7Gjrk6NGLme56EBVewNGxSVdpVtgcRkJ2C+SWZbvCBMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8027-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viorel.suman@oss.nxp.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 03CD4CB2D3
X-Rspamd-Action: no action

On a soft reset TPM PWM IP may preserve its internal state from
previous runtime, therefore on a subsequent OS boot and driver
probe "enable_count" value and TPM PWM IP internal channels
"enabled" states may get unaligned. In consequence on a suspend/resume
cycle the call "if (--tpm->enable_count == 0)" may lead to
"enable_count" overflow the system being blocked from entering
suspend due to:

   if (tpm->enable_count > 0)
       return -EBUSY;

Fix the problem by replacing counting logic with per-channel state
handling and by aligning IP and driver state at probe.

Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
---
Changes since v1:

1. Moved device state check into the probe function. 
2. Dropped {} for one line blocks.

 drivers/pwm/pwm-imx-tpm.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5b399de16d60..c87688dfd406 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -62,7 +62,7 @@ struct imx_tpm_pwm_chip {
 	void __iomem *base;
 	struct mutex lock;
 	u32 user_count;
-	u32 enable_count;
+	u32 enabled_channels;
 	u32 real_period;
 };
 
@@ -282,14 +282,16 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 	}
 	writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
 
-	/* control the counter status */
+	/* control the channel state */
 	if (state->enabled != c.enabled) {
 		val = readl(tpm->base + PWM_IMX_TPM_SC);
 		if (state->enabled) {
-			if (++tpm->enable_count == 1)
+			if (tpm->enabled_channels == 0)
 				val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
+			tpm->enabled_channels |= BIT(pwm->hwpwm);
 		} else {
-			if (--tpm->enable_count == 0)
+			tpm->enabled_channels &= ~BIT(pwm->hwpwm);
+			if (tpm->enabled_channels == 0)
 				val &= ~PWM_IMX_TPM_SC_CMOD;
 		}
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
@@ -353,7 +355,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 	unsigned int npwm;
-	u32 val;
+	u32 val, i;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -382,6 +384,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	mutex_init(&tpm->lock);
 
+	/* get enabled state for each channel */
+	for (i = 0; i < npwm; i++) {
+		val = readl(base + PWM_IMX_TPM_CnSC(i));
+		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
+			tpm->enabled_channels |= BIT(i);
+	}
+
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
@@ -394,7 +403,7 @@ static int pwm_imx_tpm_suspend(struct device *dev)
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 	int ret;
 
-	if (tpm->enable_count > 0)
+	if (tpm->enabled_channels > 0)
 		return -EBUSY;
 
 	/*
-- 
2.34.1


