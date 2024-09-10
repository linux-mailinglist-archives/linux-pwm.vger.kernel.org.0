Return-Path: <linux-pwm+bounces-3191-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E3974315
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD081C26415
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4C1A707B;
	Tue, 10 Sep 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPs5SOlB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BA1A7AC6;
	Tue, 10 Sep 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995270; cv=fail; b=YFzc0Vo1UkExgFFNIwOY0Tt1T2fM4xS64PDwt1TzkWzfKXQyMZ2J5b+dNOQ1IjXNflT9az6PHDY+rz1bVWG8EYKCrB0XeOP7JzlTx7PlLWDxd/lFKa46zAzQQ1q/iPqCtpXM50wy8lRkG43wRJIbWtD7jRj8EtlDqDHgGn2671M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995270; c=relaxed/simple;
	bh=ChIZ0veM1lZn/qwlonGU7aPQI+C2xOcTmjdfX9SwCK0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QpEP7JrpM6DRGX4Q5qPPyFAFCp/Uw4u8n5MEOD/cIeuvV75FJ19X5iH/9zxD5lptyCbYzyshjAwSrw4ee9kHuvJMWtTUKJcMQ/tqD08noqmzw5Xie3HWdWqvWHlK0C5Yl+Lmq72opLv90mI7e9oMEQkkl0nWfEZgprBpcsoS++M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XPs5SOlB; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grhm6OAnrAl6dtK99wMYwnomU6qipx4Vnbt4/fIQoSCqmNAZVB6GxfaqR9MAZX8HJphOfwyF8yDx4zAKRWItz9nAjNsYz8Ms7dDHN3oYtD5m8JbE+7Bfh+vhYHuhkRPQLgVCUJDbDYtUcg3KDSwMHvEfO/hymXb4fF8axPodR6A7WKtwlQZJCPd/W0lB1tKfxlLxbFOhhk4NVn4fCOb2sK8aMinXemZOYlOl2r3zrBhx/bYcfpKneNtqU7TJaNrlafzjiHf3EbLGyiFMn/9+Jit6dMLJcdQrvOIfI/DK3CTXid4+6Z/e8C0SXz7whqp3SC8DEmFX2LrHqFCh3mrhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMnGmg9QFlI3mIyY1Xz/WqTq1Sv7Vco0eKbOZDlVeNE=;
 b=mg7JQPy/cY9/Ujm1z170k14njqEeRFaHFCp+lI8HVD0mJ7tou7Bdnq0RUw60kKNMvee5no4mQdjMu9YbxDR8brvKU9S/i8aetBXTp4/psd5ofjPRrOeeBXuiNtZLV5sSgB+c0XYZxB8/cPk6zdDhGXnKBpRwttEPdnu0S7LAcDzYNK0YuIFThLUvqB1zXbh3Z3wKxGWp9Eprumy6JS8YzHocRZYes1i0kkxpkpkx50VW6au+8dwvVL9EE9V07i9XME68Z5qrYiMrVQm7XfD36GoSo8CKwoEvTM6EVUPLS6rXZ367TwKg9zM4hShhnFqmYRcRw1TXV1suEmFRZUEZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMnGmg9QFlI3mIyY1Xz/WqTq1Sv7Vco0eKbOZDlVeNE=;
 b=XPs5SOlBS4L+KODoQiu8Nj/3lzCzlifothWswO3VUM12fN+AeCd6z778fl2DuGxYjSj17EjIPqg/B+hUlXn0RPwcD91VYRGB4rOiSwh1EQlgv7L4Xe8MOIbBxNSILMY1I6/9cb3NFKlh7ouESlMrRaf9NvxwlmC8vx2W40oD4yBso5Pj8ZOvlgog1PxFfEPJPHMUIA/DuixcmBqKp3HYgRCeDtCNcUxC1YX1oMjhS2ZV4Wb2uGgGfcAQGp+Zc6CEXCrY6Wusz0sloNwRyL85TtDmcz6FGu4SxNvHj0v/7CYGJRxGeOvoK0MOJKE6cFyb7NA/4W67fHcdfOWqvkEC/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 19:07:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 19:07:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] pwm: imx: add 32k clock for 8qm/qxp
Date: Tue, 10 Sep 2024 15:07:17 -0400
Message-Id: <20240910-pwm-v3-0-fbb047896618@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWY4GYC/03Myw7CIBCF4VdpZi2GSy/gyvcwLoQOlkUpAYM1T
 d9dWl10+U/mOwskjA4TXKoFImaX3ORLiFMFZnj4JxLXlwZOeU07Kkl4j6RRSmBLuVGaQ/kMEa2
 b95XbvfTg0muKn300s+3694ztPjNCSd03XdtapbTUVz+Hs5lG2HTmR9H8BC/CWoFoUAqjD2Jd1
 y/fJwmwxgAAAA==
To: Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, 
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725995258; l=939;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ChIZ0veM1lZn/qwlonGU7aPQI+C2xOcTmjdfX9SwCK0=;
 b=xAr/1H9n9vWHH+EtvUwN5DDXhS4qqGBlW2iJ3Idb0ySVbO41MFHmkQMeC7wotQnXJa89esqn6
 YDQgz9NSkkuAvI5AisUke0/Xp8fn8cMEI00gWGzSrmLKjePdXeSqny2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc94d71-d8fe-4864-9da1-08dcd1cbd915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1p4UnRDMUJPWktoMHBQcmNuY2FDaHEwTUJwMzcvTWV3V0g1U0NVamxYVUEz?=
 =?utf-8?B?ZnpIUTlkUGsxc0Y1SzR6L1lOb3Bnc05zYmx3Z2p6L0tkSTREVWdqWjYxNE1m?=
 =?utf-8?B?aHdHRy9VMGkwZHdBUWdzK2pXRHNZMnpmWk5sVzY1WVZucWZndVlSMHhWTG9Y?=
 =?utf-8?B?Z3VzdE85QlVKYnhxeVRQZ240bldxcUlhV255OHdzZHJxYVJpd3RiTUpkT1Bl?=
 =?utf-8?B?R1JGcDZPQ0lhQ2NMTVVyOFAveHNTS215RDZkVUJvOXpxZGsydXFPampMT3Iy?=
 =?utf-8?B?aG1ycGFsa00xaityUnp4RThxM1ZxbkllSlZ1WDRNM2R6bFE0cCszYmlYTm9J?=
 =?utf-8?B?Y25Db0c1ZVI3NHdvUnNQK0tJeVI2N1FNVHh4Wi84V0FzZjVVbWhwRTRCc1pX?=
 =?utf-8?B?Y0xmaEtreFlJckxvVi9jODBXbjh3bXhCMmVQdWhNMVpMQzV1RjcySnRrdml4?=
 =?utf-8?B?RVNETmc0dDdlZWlyYVRYekZvMG1OYmhlcTZiazllM3ppQm9ZOTRqT0creXRy?=
 =?utf-8?B?bGVINjh0Q3B3N2gyajl4UldMeWVFeE9LbjdjVktYMGNWOE0vZkliaFdhWUx0?=
 =?utf-8?B?S1RmdE54dWtaMzY4b2JpbG1LSXVDQjZIKy9LYU9waTVmK2E2dTAwOTlVMlZt?=
 =?utf-8?B?QjFNbSt4UFIvQUtZaEkrNC8zeVhNbkZ5ZmoxWmk3M2VmbjZVeFNNNmx6akhu?=
 =?utf-8?B?emhUaTdTVkRWWVRXYklleS9ja3liN1crc2RDakJHQWtCeWtrT3hFRVR4aU5k?=
 =?utf-8?B?MFdwQk0yVlhrVk1abllBQVBwRU1iOHdmbEtwbnhpeXJWUkNjbGNjM3pFZ3l3?=
 =?utf-8?B?YzAyVkpxcmZnOG45VXRvM2JrSnp2bFZKS0ZGUkxIa0lRQTBuYkN5WEVzQndM?=
 =?utf-8?B?cE5KN0dEd1JOWUtlbDR3VStyeGwrUHNrQW9rQVlvUWpCSjZ5NE5NR29sVEUw?=
 =?utf-8?B?Z0FwS2U2L081TmpWaXY0WmFoSm5VRS9zc2Fac0JodGV1K09EUUFka2RkYUtr?=
 =?utf-8?B?YmdhUUlKS2Q1dmNGMkswci9qVVpkdEl6QnlrVDlYazJQT2FhWm9ZcDg4MFRr?=
 =?utf-8?B?Q3k1ajNZU01TSk5IN0owOVlHQ2RNSElxTXY3aGl0N0tEeDBjZmtjZklIamxO?=
 =?utf-8?B?YTdwczUxT0QxTVhMajlYSGtXYkhqdVJndC9KbS9xaDBBVGVuV3FyTFlzNEJ2?=
 =?utf-8?B?Y053NzZCQU8zSWc1bjR0VHV5YlR3aUc4NGVWTG94elR6N0xqK0hBM0Rjaktj?=
 =?utf-8?B?Q0xxbGZVOFNCOHIxcWNkV2pVZnpSSmh4OWZCT2VGYWRBaDUxZFd2MTgzWjJZ?=
 =?utf-8?B?SjhrMjRqTzh5QVY2MDZGeFM2V3c2TlNvYy9wc0U0Z0pnSWVNLzRLNk9nVDhV?=
 =?utf-8?B?MThXb0RQTWkzbzlzTDN2ODRxS3FGUVBvc0swUFpoRE9ISFJ3eXdGdnBVWE81?=
 =?utf-8?B?MVZSMmtuRURjbU9xSWR1RW8yNnVjbVBjRHRpdlUyT0l5ckRZY3VFaHN1RTNJ?=
 =?utf-8?B?THg4SWp0WjV2d3U1L29YNkNzUnpnL0J4YTgrQXlkQjhjVUhHN0tiTzh3TWJV?=
 =?utf-8?B?U0pQVHhPYXg0M3piT2Y5WFp6Z05xK1Ztb3pGRnJjUC9aUFYwMzZYM1B5NVd1?=
 =?utf-8?B?QVVjMktiOUZIUkRlUXlmanhNblZZeWV1VjJPNDErRU91amhHWnNhZTZ6M0U4?=
 =?utf-8?B?Z295a2FOVXJwSTVuTVJTTXNQaEdOVGE0dmJxczZZOHE4MVl4cmxKRlRrdzhZ?=
 =?utf-8?B?eHhpMW05bWw1RE9YdTVIQ2Q4WGxUTmZVakRyYkJMSFFiam5tNnVYNnlCSEdW?=
 =?utf-8?B?Tmd5dDdEb2ladk50Nk1jQm40cTREQlVOb0h3aVNiZzZXeWx4NWdWYkZ3MXFw?=
 =?utf-8?B?bS9NeVliK3QwV1ZSRzBqRDMrcUdySnBEdzRESWZvNFI4TE1lamNSQkFnT3RN?=
 =?utf-8?Q?+C4DIaSQVrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUJVZUJGeW55TkFKU2llc2pRSkUvRG5YakVPMXpEcWNIRmVZaGNjRm51Ynha?=
 =?utf-8?B?V3hlb294Q0hML2ZFdFFaaTMraFZvbTgzeS9tY1Jyc2FqbUxpQU5EVGNreTVw?=
 =?utf-8?B?SWZOYm9GZm1UV3hQeXgySktKbzFhUW96STFjSW9WdnAzdkhRbm9UNFNFWGp1?=
 =?utf-8?B?MSs0ZE5KMGNTbGswTVpyQWlmVE9ZTkJxYmFkYjkyOXp6MDRnSEZnYjdHV2xz?=
 =?utf-8?B?UXBta0JGRStqd0RZSllnNXNzWHhpUjExbnZYK1k4TGlycjd0VSs0a1Q3WTBV?=
 =?utf-8?B?RnlvNDhoeG41OGZwT3hsREtBQ2hLS2xtVWx5U0poaWtJdEFUbDZvaGgweHQz?=
 =?utf-8?B?RkE3b3RYY1BWMTdhVkJSNHBTbFFaeFVTV1FBd1FsdElEbTJDcDVNd3hlUU5i?=
 =?utf-8?B?Zkd3NkJ0cEY5a1JrRStHSSs3SnFROStqQk1oOXYzdXNwSGFVZ3ZBSVhUMXVw?=
 =?utf-8?B?M3Vsb3ZoVU1ZaWY3TjU3bVk2VzNKTmU1K1RzdncweXNueXlXU3lGZmhSV3Nh?=
 =?utf-8?B?elFuYzFIR09XVThvS3IxRW1LWW9DNThLNXlyc3lpSWF4bGtkdXZ1Wkp2Q2RV?=
 =?utf-8?B?a1AxUGg1T1djbExGdGNPZ0FPQnlZOGlLYXNGTHg5T2RtTUZmOVhGQ1M5dUxD?=
 =?utf-8?B?OGwra2dVUFppQTdDK2tqWVFtRVFaQVQwZ2ZzTkVMc1I3NStvakJoV1N2L2gw?=
 =?utf-8?B?M3QzRXpyQTZFb2gycE5BS0pCdDlUaElQNndIY3pwcFluVU8rT3JmaWhkYlV6?=
 =?utf-8?B?VERTV1E0dlRzM3MrYTRGMzF5WHJtTjU1aHhsdk1HbmNUS2hnOTAzSDdCWXFL?=
 =?utf-8?B?Ym9Ca1FGVHBiQmo0bGE4OEtabjhoeWR6S2RvcHBIby8rR1dDWFd4b09CRHAx?=
 =?utf-8?B?MVJERDJwdjJUVWsyV0pWN3pMYTk4T2dDaFJqV3k3UCt1c1hyeUcrNTIwb2Y4?=
 =?utf-8?B?TkNnNlZEdnBISjVqQmJXb1hlak1aaG1DZTg3UXZtYklNb2lhT2ovMHRLZmxY?=
 =?utf-8?B?OGxLOG8waDVod2RiTkJkcmo0YjV3VHJiN0MxTmVzaGRlUTc0KzZyY0J6M2hR?=
 =?utf-8?B?M0xxZlhOWm1ielp0U1ZoTklTU3RRejhCYmlTRkJzOUJjV3MyL1F3YnJKMTJY?=
 =?utf-8?B?eEhGbHh5MWpKSXFDb3RUb2t2MExjSWdmbWszMzU1WC9qZmJVdktjTHRBWkFK?=
 =?utf-8?B?RHM2TTVLU0VCSnlleGZ3UmF4NUVoWjNDSFBoaUN3MUtEVHYybHF6eUFYOVVm?=
 =?utf-8?B?b3ZOZFR1Y3BNdnZSUFpROFpjb0hFUm5zTGRoM2daSFgrL280WkQ0U0F3aWVH?=
 =?utf-8?B?OG1OdTVxL0RaZWxLL2cxY0JPTjhIUEZPN3ZBaUZ4bTN6bEU0b000TzEvSDhh?=
 =?utf-8?B?Z0s5R282T0ttWDRGVjFpbEdjT1FGTERQMnZxS2NWQ1ZmYzAxTk90RlZWWndZ?=
 =?utf-8?B?L3g2aEJnaDNkUzZiQUgwRzZUeWdFelM4d1h0bzNhLy8rU0pVVlZsTjF5VzdY?=
 =?utf-8?B?WnZJL3o4YXlacjExUEF0YmlOMXA3dDNYTGNIMkVGSGhOZEFhdFhaT2x2eWtl?=
 =?utf-8?B?SFNTM2VPbXFyYnJBRkwyUVF6ZVhUWHRFYmsxTE1DTGp0TG1IZHZCVzdENDQ4?=
 =?utf-8?B?ZWtJSFlHYkRjUklocXBMTjdSUTl6TE41Q2pFUE5NNFNoalRVR1hnWFN3anpa?=
 =?utf-8?B?WFR4L3BkMXo1Y1lnazhxZHpBdEg4QzFBNUhtejBRNHRCcW44VVNCNmNJTW1C?=
 =?utf-8?B?bllRMnpwbldjSkRaMlJCaHFsK0tlMnl1eXlzc0RYTzcvYUIrV1BoWWpwN2Y1?=
 =?utf-8?B?R2pRbVhKV0FSTkg4L3FRekRtRis3WGJPMjR2L2FKdWF6MStzVXFMU0pJaWFp?=
 =?utf-8?B?bXkzTUtVTzNPQ3BEN0IwTTBVcThHYU5ZS2cwZmhrU3F3dkJIQUdGRnI3Zk0x?=
 =?utf-8?B?aHZQUVNrOENhaFcxTzM1RjA0TUozMUR2aEdKVFFVYjU1VTZzZW1EZUJPbURu?=
 =?utf-8?B?NkhJaTc3S1k0cHJSaVRieXZMQlB5VS9sUVNTWHMrYVpBUzh3OElpS1FmRnQ4?=
 =?utf-8?B?TDQvRWQ3MmVlT1N5OCtCb3B3bko2RmJlZVZnM2JmUVBLdlpRRDEvcThRbDNP?=
 =?utf-8?Q?c37M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc94d71-d8fe-4864-9da1-08dcd1cbd915
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:07:43.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agsdYmBfeF0YhE5cFyrx6etlm7KRt+d+Hi8gVlvsjHq8UjP0/zf3XxwYTjF64Uq6Pu8lSHKw8VYtm+VSrLHztQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Using clk bulk API
- Remove PWM errata workaround patch, which sent as seperated patches.
- Link to v2: https://lore.kernel.org/r/20240715-pwm-v2-0-ff3eece83cbb@nxp.com

Changes in v2:
- See each patch
- Link to v1: https://lore.kernel.org/r/20240711-pwm-v1-0-4d5766f99b8b@nxp.com

---
Frank Li (2):
      dt-bindings: pwm: imx: Add optional clock '32k'
      pwm: imx27: Use clk_bulk_*() API to simplify clock handling

Liu Ying (1):
      pwm: imx27: Add optional 32k clock for pwm in i.MX8QXP MIPI subsystem

 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |  4 ++
 drivers/pwm/pwm-imx27.c                            | 74 ++++++++++------------
 2 files changed, 37 insertions(+), 41 deletions(-)
---
base-commit: aef199c66580d309697820e0846d0ba110c81454
change-id: 20240708-pwm-5993e602c9b2

Best regards,
---
Frank Li <Frank.Li@nxp.com>


