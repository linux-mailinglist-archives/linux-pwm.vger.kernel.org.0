Return-Path: <linux-pwm+bounces-5395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08302A8192C
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A081BA0EB2
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D1245021;
	Tue,  8 Apr 2025 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="b14+PI9J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011026.outbound.protection.outlook.com [52.101.125.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965844A21;
	Tue,  8 Apr 2025 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153949; cv=fail; b=pXL2aFqdRVlwtHwy9KlhT7ga24Ai4TAofjknMQMTG1qrwAZ5N3G4TlwRCdpPKQKiHgZ90ahRzuNt6U62itVw+iH8rgfMmdwXG/YNdhQmlQ4tcy+rAQfa7x+8G9PLpVSSBghmwZ733RTH+Wh9BS5gIGJBxXm0G5SQ/hX0rWb4IV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153949; c=relaxed/simple;
	bh=62s4g7YBOQ1qATyrqfdJ6+VDKI3Q67Y+tHE2URDNnNo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lrGk+pMA95jBaUWCpB2gYdZSHkUsJ8aPVxmAxW/PSbDLlQrUDufRRhc5Ou02kQl09a0zaAXDFjfSgoaE8jRDB9IigmA7FL/A/5BYFU5lgvxziB9c1W3dLIQUuaKltjzWKhxasd6vbUBDdXl5VUogKHB6M81opu19SRSwSkLPzrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=b14+PI9J; arc=fail smtp.client-ip=52.101.125.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWyeJ6DA1Gu51MtS3Vr5fE1LXD4l6bnMCUlR6l2/FIU0fwpjQWDjjWlhPlTti167Lwd/LP8S3+GSfZA3SNWbQ6Zg1GK9zqmTYmkhospG76cK8UN/WhyhA3UpFVO+BMRsmZSg76X9oRrnSkgfN6yXcgjF4DOkxhuEroiZvVZRlfv4sjQWNo7YUAxF+Ioe9SkigoenYGduGPIKnBue4IkOqjmQtlGr3MtzBMVuorxIA/8t4gmjZu9eZaP/8J6vDj5r7OS7tHg8aDsEuUI87S6jYXROQ5Wj04HYaHE3m6cOezQLmuwqfMke0ts+wrjlhzWwo3BqOFx0PCoDsz4bsS14BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNwVo4dxT54SOVA4zdw1gP9lsq4Zsa+zyRpJ+J9PpfU=;
 b=fQAQs3Ln4TMPe4ZogEhN1DosRE/rrPmry7rbrraPLK3qqwTCfGKIc96QMmxb2fjk6BO4Bqv4dCLTjfP31WZQeqkUf8Q1x9tNLuFG/lzbwu9cb/yodcCLts6TOMgzfow3myykJCFiQ+6hzDvHw1Xzabxqhya35mOZ2BZtfcQgxgj42CbhlY/CXTKB/+w2QmufDqIbI4LlMPyA3XLlNUTK942t6IMiElqLg29g+SMnRqRJwh0hCk1dvQzqowuMzZ9g6ZTK2bEXRL29saPeuk2yjypRNNuiTTx+/nr4YaERja/gGmrctlu+fesHa0iQoR1WPFYIt2jD0oM6W7gcqSTS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNwVo4dxT54SOVA4zdw1gP9lsq4Zsa+zyRpJ+J9PpfU=;
 b=b14+PI9J6ORZgLRlCnac0BnZU/+U6mrcepk8v4WQ4rSwguqqk/Id4v5aLrnKxP35ojcAPtmvH0HF2VrneIsIjLOYsAmXNjgiSvs6qYx/dUZNEjsY2WNebK2V6aj1xSZTDFxHQG721Dj/Vahc/0O8FH3OcZ6mTE8Um8LioxBZllY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS0PR01MB5716.jpnprd01.prod.outlook.com
 (2603:1096:604:bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 23:12:19 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 23:12:18 +0000
Message-ID: <87a58qb641.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,tpu: remove DoC
In-Reply-To: <72v3ymskrew3kvi2uzjoq2gewp7wnade75tjl4bfp7sw35h2ne@rfc5mygrgb2y>
References: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>
	<72v3ymskrew3kvi2uzjoq2gewp7wnade75tjl4bfp7sw35h2ne@rfc5mygrgb2y>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 8 Apr 2025 23:12:17 +0000
X-ClientProxiedBy: TY2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:404:42::25) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS0PR01MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ad2a97-52dd-4cc2-67c3-08dd76f2ceb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tf/eXy3X/0jj7B/NOvOgqpO1hIgOSKWcb7tBKkONABid/TUeLWObVMvAglsZ?=
 =?us-ascii?Q?LnhxMfvMZLypWMIzyqSDAObvNwOCY6VueOYzg0NNss/uBLdogTlYeU9m9wTP?=
 =?us-ascii?Q?bfNMRwkj68cVqzZrr1XyJffHHMdKKM/JoxrHGUZyicZuYpWozt1ipOIjKt5y?=
 =?us-ascii?Q?vZR3SxbuLyeeo88324VNpjYxa2/kFPkGLFd8msQcW7VYcbQb8Mb7qkMqWCr5?=
 =?us-ascii?Q?QuIUS2oyjo7lYCVj21gpO81aW0hIMGvWo7CsHDlO39r0WTH/pEER+yyc6U9O?=
 =?us-ascii?Q?9RIzH6v3jhIH3fUyWhJBw+PlDqaA70KyqNNpa+KC3IVHDd3gwEGBE380Rpfs?=
 =?us-ascii?Q?8QOAHDlfb73El6ixDc7+cNHhjOA9TW3rqZ+mJkydSySWH10YVPMLcgH1gg/6?=
 =?us-ascii?Q?kmtuDz/FndrxcDurahkWYfF6BkWlJxL8MPny8hve2K5LKDNUbKSqhwkX3lhV?=
 =?us-ascii?Q?GAjOZk5sx1VZ5lQqTD20/drjpAdCmjjZWRY9Q7Gz7EJvbVcvVhxE2fugZ8zC?=
 =?us-ascii?Q?hyMQfBVG2wiHFx7sJDMWqNH2T6GtwldLv6O+aa+0cbbUtN1x3LOyFOcFDstY?=
 =?us-ascii?Q?2NEuIQWRDYtz/7B4qGsPtD1Q1WYZ982LSkE35RQLNtvNFAB3YujgeSjblkc8?=
 =?us-ascii?Q?3QbV27EnjbCxBGqhBOCZy+r5rN9dozfa+5lKxj9xhsaXeiICQgZ6O1ouvzSJ?=
 =?us-ascii?Q?b42WSsmIar/OXP1PFQkrD1Pa7Alwq2O5u0JrTazLge1BX1wBoRWPViJmXBBw?=
 =?us-ascii?Q?V8agJoBiBCbNuDCrnXzUbtBLwD3qWPvJywZsSoqYwkZTv+xM6yt8+oztDg+x?=
 =?us-ascii?Q?L75N31hugTuLQXXd4ivO7xsfiBPLn1nCUiqa7MB1bM5Yg0rIrGT/PAoDsoRb?=
 =?us-ascii?Q?qMRSFZjYtt9ByWHRSo4tBbf/2XWK0Vs8enFmPshrE4OGkmJ5GEXlhvH/lPQY?=
 =?us-ascii?Q?lgXcins6XlbU2r2oJf8q905lH1hzu9ceClSWJsxWqR0YFQw4GRjths/n/n4V?=
 =?us-ascii?Q?ovJwFUDSAviP/7Zpt0e5YH4rmSXCKhh7zRgtvFuaszjVmU0+RYsHKYU+hwqf?=
 =?us-ascii?Q?owiGT9tTDVfwIEuY8buyK3tWyh1lTm4x7CGRFc/pCF0nCk+V4oWTOyMNO1uz?=
 =?us-ascii?Q?3Lj8Aabm0AYuCn6XmERCIvQ4Fi1/L0k9ty0Fra/MT895OEqimLTseIEeaHp9?=
 =?us-ascii?Q?nZI+RSBfPCh7/I5Wk1/veV/vohWYsPhpOKkMaphanmqdDTdKKOSZ/xnuIz8l?=
 =?us-ascii?Q?3UvuY6k3dnvhGojf7sKnW6xZUazK8E5F16Gbxwt+x0vsv90mLTO2qLej+vfC?=
 =?us-ascii?Q?N1zULXZiebvvJA1/H5TQ9VH+6pY5pcdMxHDe0+PDBWH7A/J+yI2pDiT41b3z?=
 =?us-ascii?Q?bi8tjtdfmB9wpoMri5JQRXp7hmi3V2bkRUdWUgrhe8m+xqfe24obqYtRMhNW?=
 =?us-ascii?Q?9kuvDGXf4AvNf2P3hHe197ZyL9VO3VxC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aS20jL26A8jxWGPlwGRxFVsQuFxWl3lwQzGqwraGIrIKkZgqbF+iuUGRrNYY?=
 =?us-ascii?Q?RBIdm5Y2m3NAijYCSzvkEsiBWZRp2yU/KS54TFaFXBvbYYBma4+iXdTl42BF?=
 =?us-ascii?Q?lRFcd0XdKDHsPzZV1rHrC1SNWm137NjDPeyYprHsHweqjHeCnM8waYOAghGz?=
 =?us-ascii?Q?RxlAr9rdY2g/OJUc4qXX5PqmsXnrnqtpWhsCGyJrWk8Pa71ZFahxAJ/GdDN9?=
 =?us-ascii?Q?CdycjM3POxTc0aJDaX1M/+51P2dUMbrF11LcsHNyHF7eRK0VkvBTdaIaA3vG?=
 =?us-ascii?Q?GDv0FhM9ESLPsJA7eSuo5dXYUteMNoWULXl9yCTrCwjqdaxaJEebefUcPsSA?=
 =?us-ascii?Q?d4/EV/dOf+TKFZ8upSrvsuVzddYSmoLgSG9YYDKi07QJzTqwyD463+0pQuge?=
 =?us-ascii?Q?BrRpeRol9ygiII9ejyd7p9K1h69UZit7PHr1iUxT+E1uFiEpcQPB0N2CV6/5?=
 =?us-ascii?Q?TdobGNX9Oe+bqMlOPVFqIWW9KOQpF9NG4ulc0/ZIRBi1YteOc2TQb8PvmkoE?=
 =?us-ascii?Q?2AoWeDto29V+CprJxWeeL8EOeXnz4L9gCt51krEZg7imDV8X1G4WVfZyx2ZS?=
 =?us-ascii?Q?DXKgo3fNAteFDC6tlyfvC/aoawAJvitxi8PX4qozwBH2l5KC4eXDzY7KaT8a?=
 =?us-ascii?Q?oiju+xY6tjPkDvrTEbA3zmtqUyz6J7ba9s6LvcRPVQpUjy5ndu8bqaOmUGgD?=
 =?us-ascii?Q?0H6hnlr8iwq1BaJ2QlK0Emex52tEc0pAxMCCBlRCGDOIdkrd8uRXMhijfQZ1?=
 =?us-ascii?Q?XBtq4b54BCNUvHac5+XfM835b+WRpKZNztnz9kif5T45C3kvBzzc8Z4umuUN?=
 =?us-ascii?Q?aQsf0kxCKsHPJTU14GtSugHAF89gnmclr8Xgj5+BUpOBvLOVP5ZCp6vbSC0b?=
 =?us-ascii?Q?GblA643oOwShZqzTYVrVipmK/a+Zzeogb/NPioNoMGLKEPP7hnhqr1PKrLXh?=
 =?us-ascii?Q?0sq4r6EGq1Mi9gZUGadPWViroXOHqugzyI0xka1W/ZxtGFA1nmTSULZi0cDH?=
 =?us-ascii?Q?etWrUMxEO3rjFjNZy2kpn3sFu5IsfJ5N8cEM60lajjdhFuBE0fuaEs3laEvh?=
 =?us-ascii?Q?t+gkgpR46x88yGlayP00Uju6iJgXRqldrE5lLWIjhV4Shl12nsZsKryMgKjC?=
 =?us-ascii?Q?zZW5aE+FUVgH5qobf+pW87TVbuvNSS/k2JFDglIdC+LRmr9RgOEx2Cc6uXm/?=
 =?us-ascii?Q?y2Fyd1Spco4oAsjYUHMRGWu3QTWw1zvlnPMFa43GVHSRfShyQr1WJcrEhN3u?=
 =?us-ascii?Q?fq0PdqntfYmPu99bMQ3MmqWVFckU6LIeks50gWFsuumJDfDalNH8D4kDshx6?=
 =?us-ascii?Q?j3GiPNu2zV1PrhWyvlc1XCcToWb9wiRiIwcuJ83gECweKB4xQJwFC5/B9qYe?=
 =?us-ascii?Q?ksHUN8PWNWiL1+S+91SjT1/j/cKugEEOrmVYgEQLe1yHMffvkl+KGA8rjjq/?=
 =?us-ascii?Q?6WL7WLq5M0FX+zxy1L3RapDhzpcar/xzvIB93MC635A6gO/CJ5BdyZ6YlTAr?=
 =?us-ascii?Q?8M3GdNTAkIMnZponVcvu1vIr4RjgUudsos6FA6efBkC28cdQ3eHhVReUjdi+?=
 =?us-ascii?Q?5WvzpW5BnxF+3gjUTmnZx+yAdM0YtuB+JFYOOwXwHEXxdf6clwOXdR2Xsei+?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ad2a97-52dd-4cc2-67c3-08dd76f2ceb9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 23:12:18.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4QwG0oEEq/WrKztU981y/kMpR5ReXwbNbq9io2hVGl0FDJJN1BVlX9wC9QwG0dmnHfnnmOO16p0Og5R0NwzlmW0twRoFOJ4uOTLFqkwo3WJsdF14HFVrBqp/DbsTMeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5716


Hi Uwe

> what is "DoC" in the Subject?
> 
> On Tue, Apr 08, 2025 at 06:09:15AM +0000, Kuninori Morimoto wrote:
> > commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
> > timer driver. Let's remove its Doc.
> 
> s/Doc/binding documentation/ ?

Yes. Should I post v2 patch ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

