Return-Path: <linux-pwm+bounces-3544-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C29957C7
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 21:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE36B23A12
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDD213EDF;
	Tue,  8 Oct 2024 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iV9gi4K3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D521E0DCC;
	Tue,  8 Oct 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416512; cv=fail; b=pmrzGsSGkzRF1epfWBa7K89Qtkf2lHjMNeQ0WL0Fm7oRLOkBrRA1kT39/NTCKk6h5oBsNEkwodKKhSWyZbuC2+pR/dmztFWM0iJd2WJRjhROAvKYaD1sfEpW8g6GVpbQ9Tup4dn8Nn6Uvp1ayJjNV7/ueq/cUQ2ZjGjWYSGXc5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416512; c=relaxed/simple;
	bh=w4m+C3MA+uF99iaYqBpHoN8HtNlLgOwjLrQS1SWbCDg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XKlCQhT3ry7p8+GWFSiipcwftqE1a2qmlWSEIeyAlcM4CysYut3/wrvCyN/UJmvlDW6GdhOMFKVVf2BwbsurLiKVb6nVT8bj+HQVRxevtW1Ll1B+mO6J06JBAGkWhZ6gU/On1HQWRyZNIepvMaZR1IhKsrlFGDgRqYxOD19vFRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iV9gi4K3; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyvkddGhVIUq+NJHWhIE39hGASP2ix8DbuiMETw2zCGv+Udj/v95EoSjcYr6KsGmgFrGHhmit96u0RMmw2iA6ioL+G0WfSyZsCiGMyM3F3Zcz5AyaZfnzRvPC5rYLIwrUP/hD++7fnzGZAGoS3tvMjjFnT91q4Lz2zpUED7Fo72nSgBFiryOCdx5AC/4u+gMr/0cFRKfCpUOWPjI/CcLnbz7VFz0QP2ciBpbgXo/ZgqwOZ0GZ+ny5xnYx5ekKxjfU8fMcpYSnALmGSHR1IPUp7bcepdAAbKkJ7uya5NoAFy3+ZZy7gPdg6AStyiQkIedc9bQkcWJvqcDG3zmkul6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQqM2YdVVqMejLuSUwuShuQnVSs+FR7EYfdGkIIsH3Q=;
 b=VTWaADAdMml3oVBI2+cQPPzLrMwWlMgJAX8jMD17uItSQ7jM+7r9OuueN2n+vV6DkB0iTPJNprAVlfJbvm9Cn77AU7q291gjQGslGzLt/5rxEmUx3ZRUbnXfXrTJsw0tF2RR6IOCLljdu4mL8fvmNE9sRY3rHCK5FYXIdRJD1jp8JB6ivaGER3t94rn0+UWEr5kP1G9MPjQjAIbRelcqLoGO9TiGUsndXhVVNG3pKFGRmM+OhjrbXlPMf/Rtzd6I8SKwXmj2QsMcsBv0VLMOFyYi1vFjMESEsof9stLMxtILiSL4V8XJnYO5yDIA61GaQjU+7WgTeH/xB7FeRKaPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQqM2YdVVqMejLuSUwuShuQnVSs+FR7EYfdGkIIsH3Q=;
 b=iV9gi4K35QvRz3tKp5i999ROLCNGYKknYVIbkRcaAdiq1gdD228E3PvhkOx9/WsdzD+7fnB0H8lXV4UvadWIHcUNbA9VK1+RnOIXFSuRDQzlRkVB49guM91Da57lKKhr5/O3IFRJzeFJoq/sIMfmoCUu9pnOZhK92Vpwh5VcVWnDRevtriGVyHy9HyfAia1ZoumiJ5m36Ng+3hHHtu5rbSk1t2Qa/WtG84sDIibS8t29fKuKG/5NstX+M4OR2KfBgSfbYGWXE1j78E1Q8USi6zsC0hseic6qJ8Tfm9HlmaBKYbyd7WmQ7Pcx+yWFp4uiv0luuJqtlEr632yaN1mpvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7138.eurprd04.prod.outlook.com (2603:10a6:208:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 19:41:47 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 19:41:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: u.kleine-koenig@baylibre.com
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
	marex@denx.de,
	p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	xiaoning.wang@nxp.com
Subject: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when decrease the duty cycle
Date: Tue,  8 Oct 2024 15:41:23 -0400
Message-Id: <20241008194123.1943141-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d15dd0-39f0-46d1-4986-08dce7d13e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5Vn3kgd1gryaNCc50ug3RCpHmpX08VASDwSsCe5OUlNOJNRc/mmYMdkHaJH?=
 =?us-ascii?Q?473aHteaLNgz+nEn8N/GX4zHVRNCTNDo7qYhefLc2sbOWDDJ5h+Hp5nnZA3z?=
 =?us-ascii?Q?TFmh8GbU8yiOI5euDsN1VzDbYY4ETceBXSDFTx5V+eqCJGS6HnKdCyyqg30q?=
 =?us-ascii?Q?NxxOwNQea1r8xdJNah87p2LTOXsY7gySWOVI7GzApJNeEyqzLxT0FCrVmyF4?=
 =?us-ascii?Q?EXrGyJCuxTVpZRzyU7Tg514R6hWEei0dJcZZFmJi+DnqG6SflT1A8kxdFuYh?=
 =?us-ascii?Q?TFG2DHRMZjwvSqlmnd9y5gX9rPd4F18gD27JjrWSnPg0D7zkDikzmpVPKKR9?=
 =?us-ascii?Q?dxJyGsNLMNMFDnScFKdpUHHaYesv1YWsSZeIIwXZKu+CZHTDAo7jXZJYw2iD?=
 =?us-ascii?Q?2s5v16IgdVAkTmm5voJvRON/1SX85YUlo6JvtYeWoKXhgbK0uLeq9/U/BNjs?=
 =?us-ascii?Q?j8BDjhzHE3sYPhgKNOMcl3lhM6oWhyLw04MSEzHrMlY7daiiyDaiM7jFyQs4?=
 =?us-ascii?Q?9khEXC4lM/l9nk//mjIQEXSt27WJeTJwbu1lY0z+BQ6EyZyUZo8xs9d7GIXD?=
 =?us-ascii?Q?RWyn1dqIDzT366frW7+degYTWVheWoWd7PKJLysgN9Bn4GEl8dzvztwNBL6v?=
 =?us-ascii?Q?0MKO2Nca6JiSiaQ+nGf1GM3oyQiFfZK2pXy0xTsoM5GntXMY/yR31hvbUl3a?=
 =?us-ascii?Q?nTfxdzzYq9r0uXMBlG49n/SXFzs3/mD7qZATQnvDySxee2kNmYQyRkOwMYQ9?=
 =?us-ascii?Q?ht9DU7oJyrGh+DwCHvX22IsxDOpAoCgefuwH84gPEhNkWHG19UGdPmbG/tBO?=
 =?us-ascii?Q?uTSkNutR6+CGOEiiJsh7awy92KRTh8HESZlSB6ycF/w9u128DQxxi23p1AF/?=
 =?us-ascii?Q?heQp0dSij+baTejv2VBSccVbQXD9OnZ+LuU+cXHEiU6JBxNM1GORc0bNvCkn?=
 =?us-ascii?Q?h+dBEVvF/Umgz/47xUaVoslRIxWrmJBxnBYq5wpCSAt1SwbgozMPYhyCDjgB?=
 =?us-ascii?Q?pTA59Be1hXy+EQUqrr8A9FFkdacRY2cSMOsmSBNNia9t7MTFjl6hhobqAO+5?=
 =?us-ascii?Q?oWcSjDJsFBOpqk+HjIMNb7RxmAZ05Qv1ZhZ9FRBMt3FocYqlpWKOHSFGFpMO?=
 =?us-ascii?Q?VsGmw+BiNRVdGuh0mEVZDmRySQxXnF2JFYbrYgOQlGCKrQ8qHtikm7m86aEs?=
 =?us-ascii?Q?X3R8iHHeWAII4wX/rC6HADzV/3kKs52e03gY28El5fDjnOrlkRQOYQJTgMXx?=
 =?us-ascii?Q?fdi8A9oF4JX1I13OijhhtpTxCn8hW2vEwfchHzucuBrcd3wYsG0/RpgYLIPS?=
 =?us-ascii?Q?rnmIn0beypyJ3lIoACG09kksWvfzALpvjx9tzC4Urzt00A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wGXK1VAsLLSDkyiHyHjV5J8mvICS3IrkdNLFtttEuizbEnYwIVFdWrTwskq?=
 =?us-ascii?Q?AkDKAeQwg61S2OFG32xKEztdXMrjEfqt59a+8b+6vfLbYTJGWGpnl5UtJir3?=
 =?us-ascii?Q?j76QYBfQISnPQcBQZyJiWA8o2xcHMDVcCxTfaADWwv/YR2elrt/GUSJ7jIfK?=
 =?us-ascii?Q?X4gnpqVq7gkUFryzf0Pk8IjduCpzQLxsb8g6V8zx4tRy0B2Uk6upqrcHJROq?=
 =?us-ascii?Q?U5ROr7PNb9SG+jEEI7YrSH1Jd9WDC3ZDiKejsfWbN3w8AaYw789M9s3Zsi7d?=
 =?us-ascii?Q?VODJ2bInLsYDrdNjUjFJybHwJeOswNCIB+mm6DxAMlUPMhNpexFmHDgQl5Dh?=
 =?us-ascii?Q?ZhIrkPOG4OZ6/xckHsOOkMgw5QlOIBYueJK+yyiHt5wzv3uZfO525XklRKjr?=
 =?us-ascii?Q?vcKgGZInSUVQx21ZCUVfk60zSo4PHX1gytrU1ueqQLNyjXS75apJz5IQIu9b?=
 =?us-ascii?Q?QKrt9cr+3bsVwHyUn9Fk3XETvygMiLXSXXk7EQRBO4x78IQSvnYxvaArY6CE?=
 =?us-ascii?Q?hT29m8FuSW9ueseloP3EaBcB+dX8AqKlRknaE+s0I/KKdCy82ZmsbMskdbY7?=
 =?us-ascii?Q?FELWWotTTJQWIJqtNh4rjRc2vm1Y4VXTq67aWtuMmKRpEipl4RO4mN0TVKQt?=
 =?us-ascii?Q?kMFI5dQwdIJcMclKRbeahzX1O36mvVDBiUAclBe/DWdq0B00/Prgq/org1tU?=
 =?us-ascii?Q?147bmBm+84p08jS8/z87b151IGm7lR00hPupseEb2WAmuCU65/2JHHNdDXXv?=
 =?us-ascii?Q?eorbN8S1UdOsU1yz/JZjqWulvHPdOhUKjuNwkLfWO7wfXMxct2rLmCqEqEwu?=
 =?us-ascii?Q?G2GjbUHFf+HiaNQVEctJQbpBtudK9momrpxR1CoFEICHG0iNQW4MW2HOoObP?=
 =?us-ascii?Q?sKgoZ1VGIOScwtLLLqknslVkqbGDYnp3gVbCZXv/fUEQrViB1lewZRxBwZlF?=
 =?us-ascii?Q?JOniGh12gQ6pjW0Y5KdFCJ/d9GJJV9VrAnxalc25l4ACDRrujXY+X1NY1OH2?=
 =?us-ascii?Q?BoyoDlFTSy34j1EU8L5maAW3ln4tb+dkisXUQfLc0RhHEvNxAFc+EEGnWy6v?=
 =?us-ascii?Q?2U1gs5QLlNUBneVrO4lzPXzLBKiZGYGjtGlRyqJDTEU/tplWckATS7CVksE3?=
 =?us-ascii?Q?x0RFDmO3p/9R6CfBmTvwyfcjFaDBAX9F0tHEM2jODROCFc+59PH8KbxhblJG?=
 =?us-ascii?Q?fQmhK04QmQJNGuLoShQPaoWc9SspQdjyLvua7sP3+wO1LC4qO/9uVoQ2PF/+?=
 =?us-ascii?Q?sEzRNxXo/AW+IFLeOia1amXoaA1tmvjwLMP6N26Od7TB19euVdZ+rfPTff9/?=
 =?us-ascii?Q?AI/+bfLxrY2P93xEh4rs2dZlL3ptF0Oe3TcnF5ltDDBlr1HEcAkRoRbD3FJG?=
 =?us-ascii?Q?AxAQJdCRYy7ka1UwvVVDf/lnfWLu6k5pu2cjgSXCz6zzyHr4FcUBl0G75ORI?=
 =?us-ascii?Q?7gcghmJiLC0KcghdcZh/aCFyrLC0FY/12f4tsrtnwRPrGyVN72UEjCp48wtd?=
 =?us-ascii?Q?afRZNLQ0CsMylcXhRJf5ZqVeY8SnGc5mcEwklLZOOMpva9fi9PKbmxdGWiFa?=
 =?us-ascii?Q?RWwnDT2X4xrZQhv2fZkc4s9OfT2QWOcKTJREnIWf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d15dd0-39f0-46d1-4986-08dce7d13e9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:41:47.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EduocVXZREFp5/voTMZB4IgUuErB+/74+OqT5x8ac0o2IQ0mtjt5ZKB91aQRWnC/e+TgsHmMOo5gv8bcbWhKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7138

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
  echo       8000 > duty_cycle # One full high pulse will be seen by scope

Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v7 to v8
- combine Uwe's diagram and errata document.
- use old period
- use udelay(3 * period / 1000)
- Only apply workaround when PWM enabled.

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
 drivers/pwm/pwm-imx27.c | 98 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 9e2bbf5b4a8ce..0375987194318 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -26,6 +26,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -219,10 +220,12 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	unsigned long period_cycles, duty_cycles, prescale;
+	unsigned long period_cycles, duty_cycles, prescale, period_us, tmp;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -263,7 +266,98 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	val = readl(imx->mmio_base + MX3_PWMPR);
+	val = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
+	cr = readl(imx->mmio_base + MX3_PWMCR);
+	tmp = NSEC_PER_SEC * (u64)(val + 2) * MX3_PWMCR_PRESCALER_GET(cr);
+	tmp = DIV_ROUND_UP_ULL(tmp, clkrate);
+	period_us = DIV_ROUND_UP_ULL(tmp, 1000);
+
+	/*
+	 * ERR051198:
+	 * PWM: PWM output may not function correctly if the FIFO is empty when
+	 * a new SAR value is programmed
+	 *
+	 * Description:
+	 * When the PWM FIFO is empty, a new value programmed to the PWM Sample
+	 * register (PWM_PWMSAR) will be directly applied even if the current
+	 * timer period has not expired.
+	 *
+	 * If the new SAMPLE value programmed in the PWM_PWMSAR register is
+	 * less than the previous value, and the PWM counter register
+	 * (PWM_PWMCNR) that contains the current COUNT value is greater than
+	 * the new programmed SAMPLE value, the current period will not flip
+	 * the level. This may result in an output pulse with a duty cycle of
+	 * 100%.
+	 *
+	 * Consider a change from
+	 *     ________
+	 *    /        \______/
+	 *    ^      *        ^
+	 * to
+	 *     ____
+	 *    /    \__________/
+	 *    ^               ^
+	 * At the time marked by *, the new write value will be directly applied
+	 * to SAR even the current period is not over if FIFO is empty.
+	 *
+	 *     ________        ____________________
+	 *    /        \______/                    \__________/
+	 *    ^               ^      *        ^               ^
+	 *    |<-- old SAR -->|               |<-- new SAR -->|
+	 *
+	 * That is the output is active for a whole period.
+	 *
+	 * Workaround:
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
+	 * Use writel_relaxed() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest PWM frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500kHz), this workaround
+	 * can solve this problem. No software workaround is available if PWM
+	 * period is shorter than IO write. Just try best to fill old data
+	 * into FIFO.
+	 */
+	c = clkrate * 1500;
+	do_div(c, NSEC_PER_SEC);
+
+	local_irq_save(flags);
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+
+	if (duty_cycles < imx->duty_cycle && (cr & MX3_PWMCR_EN)) {
+		if (period_us < 2) { /* 2us = 500 kHz */
+			/* Best effort attempt to fix up >500 kHz case */
+			udelay(3 * period_us);
+			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
+			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
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


