Return-Path: <linux-pwm+bounces-7101-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A83B2C958
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FC8727E90
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB7F22F76F;
	Tue, 19 Aug 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pIm/Q1OM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C120C461;
	Tue, 19 Aug 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620357; cv=fail; b=hIRKbM1wogP+20J+syjmQ14AmB6EY+A8djhVQVqTPRM2o8pJ9zVqs1JylcPNIUoywJZDeC9qnCC1jKG0cdcLsWBzt6/JlXH3/8nQAGjiVtI0wmfK7Qu39/Yvf0n80EpsFMW3ebExvygzUKxBL7wlU2sLkmfiPZU3d58vWJluPSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620357; c=relaxed/simple;
	bh=7sZsI5MzcmqPvUvvVQhvyjIKDtq6AnpetvK7DYDav4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nm4O0pU9/7LM8Mn2hMAuLKXvbd3/etVbjqgsVZfvFcBj62dK29nnUDRyoMiWS4QxC4hnILqhDgzSRQuYWQXJdQWC3zVUNzUgp2kdwaF+IUsI0WY6qBB5LDn9FMuHVLMprvdryaTd/FEsWO7euSyUJ3Eqy/7k+TcH/GmiaKWDGFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pIm/Q1OM; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMyEuqoaUAvAIteN8BnN5+BPiukIZYKs18iGpDxxDL74Fu5Akvcf05AdNcRDR06zlQewZPx0QsJgsieCY3LxC+5M8FhRkNkD+FXhdkKCX7NUYXAEi/vLh6LaBFBkN3O8y3LG7Skbp3kjJvM24zJcN9Qu/ODtEKAuwWo0hvp33MW4wkgFc1Pr4yzl2A5jamBHvhj2GQYoMzLSqt2co+yeVIICbJG11dOBzscBbVF+Eda7AQOYMIuSAY449wUisZDdQGpP0lgEmNbn1jGDRUZnxsTiDxwXuk6yIT/CgMOlqm98NeoBOJ7dbMk2xRKQvUl1dRy5DuSifV38SrV69wrJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW/LgGgWCiu56viqtDsAQd+OFP6zo/SGbxDJEMOcV2w=;
 b=kwct+UmT3RT673sRE+U90/MyWFJ+4v3DHT7MUIb6lwGTYm919qCqWEl9T8oVBGgeCAG29Cl+jrBwglqJQdLBabLFjbLG1CuxOvDWN/lMev7sw5fV5VdldfbL8GxWQ6LhTcP7WQEKildfAA0VDJXAmiSu/xa0HxR5NTEwsVPIuH4g6BDEe9niQJIRcaX7gozoFFvAQm+w1qIOVFycH8F428purILVX0KjvoA/g2/QoYkE4Zyc1WJFL0kkbbFvlgI7qtGh37O0bAzKeb06xMEVFycLj5Gmc4GTdypUa2foIBQmhvVu5/QjFWC1SvtM1r0GZIGrgYahHCpD0yKDnjMeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW/LgGgWCiu56viqtDsAQd+OFP6zo/SGbxDJEMOcV2w=;
 b=pIm/Q1OMQ4pWh7tAotvgUjhPhAO2z15R2K+zdm+tXDzevzdFLljRKwV0j611SBGz7HLibo1CVIbVAd2bC+ipIV5EhaPoPevjOH3JHNoWX5BAIGNFMMpaJrVlKu1TyKRidDgrSLP7UqQtuxAx6pmMr5VNP1UUMopc4iuqjPPxRnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 16:19:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:19:08 +0000
Date: Tue, 19 Aug 2025 18:18:49 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/7] dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ/G3E
 support
Message-ID: <aKSj6X_jMyB1f95I@tom-desktop>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184115.192930-2-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c3dc8d-9b18-448e-6672-08dddf3c1fe9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGWitxUNA7BKHLNPrqo4CaLdbvj0xHhsUJaaVGrWjO+illEgk6ccNL4YKHPc?=
 =?us-ascii?Q?ypXEETFOht+HojTuQU99Lmo1uGfkYClpmJSLM2/bnzKZQQw836B3th8dgpu4?=
 =?us-ascii?Q?IPGrDH8jUKvfIcpRZJrmmLTOmvRPMAw6fiqwv5I/lVgy5Swom8Qmn+6JP1FQ?=
 =?us-ascii?Q?kVjTYWJxIRbB8fdUeVHNqhjdMrUPEwpxFkiOOPd7e2UyBfaloDfzA4LxDdky?=
 =?us-ascii?Q?WqoZ0uWlqgaeOJIa3NhuFWIhOHtCES28W2m9kSCMcwA9dqNNrzOVna5ZXfdP?=
 =?us-ascii?Q?vHmP4Fh7YW20fRO5GKpYgm/XQDno2zMCAY8jIR+SbAKWy10jbzxKCySHRtDE?=
 =?us-ascii?Q?Sgl11U1kYLjZ2FEaRffQpefrbqI+lxdgDZDmsuRB21C1+1Csnayo8OY29IgN?=
 =?us-ascii?Q?LGHRTP0txBvG4Aef6ZcZDfMNBlXBoIKe7Vxw/orr3LdmPdpNZGQZB8yLm5gT?=
 =?us-ascii?Q?sWZthFQJ8cGhtiaf9++gdmIrHtfuo6kABWYi12aTMcQEWscv40rOgi6ufpsU?=
 =?us-ascii?Q?AEdsfJgmbermm/7Zxdu/XWg4CS1jTdBrzk7k/iXkceRJYbMxJAfoYJzAFa4s?=
 =?us-ascii?Q?Ns88LBHW79L7t3iZXpkRvrfp+8cnqYOibC0zx0IQg6PhhXggYIY+a2INsNbm?=
 =?us-ascii?Q?8f4+himdVmb3eNKbih0z/G6AnWL45YpNUh76Aa8rTEP7SE2RjfQk3FqHos3S?=
 =?us-ascii?Q?OUtkWkwXR0mdfBDrPu8bRHpODPJMhDwrUXPs+UeSJf4pIbe4lYYjlVBQcXsl?=
 =?us-ascii?Q?QhWShFqY484EWGWtZyZO7huVFNSeSC74tPNsu98U48fjDg+JBA1c0PuO3RKS?=
 =?us-ascii?Q?6LAD+QgvrKww+YC9mpJEKQNJEsa1BUsdB/3kFmMAx8pFln9nZvjXrp9oWSBT?=
 =?us-ascii?Q?6/fwS2hEm2mx+ze2O3kpK/OlRXP1gi23HGnlUHnJgTz1iUF7WRf9fzug8/bR?=
 =?us-ascii?Q?e+IEyCR/LBVGbLvZ5rAhdHxxv9CEWOE3ZYd4gmDYJ+qIlPEMVN+ap/U6Qzuz?=
 =?us-ascii?Q?yT94Q8s1GORQg3pBxe6MtGOetW1NMYxk1yML2oSyoPcjW4xIxDzgjMlgSGG3?=
 =?us-ascii?Q?bt6bkrkGvpUsGOAx4csr6NLV608s37dZV/cISKVkqllgnnMieCYmKja1w5l7?=
 =?us-ascii?Q?YqQGGwTLPp8NkmgB07ijfuyeZzsy53rQUmu5cF90NOB9SBKiZUQXo93MNKKO?=
 =?us-ascii?Q?xuqDd+0tKneBkTqtCCFLSJdvyI2afnPNjxX6dOw6WfHrN5TxV3d2SbhK91ml?=
 =?us-ascii?Q?LWVxh/IMgT8B7yEGs9JW/kmLB+38aG6xsTvoIxc52NqMdPYpRpgVv4OSRtdL?=
 =?us-ascii?Q?6aK6ixcrUHpLnvEwOLCvLMvC7V0+2G8WQkVhpXDjaBQO287y67X9ENlgQv4m?=
 =?us-ascii?Q?+VHD7v9ERau6w1tlI3BEcqIi9a868pPTkbQmDkudHMeYK8UZFaldm84QbXLl?=
 =?us-ascii?Q?Cy/Vdqvp+k0kNDfdbaiuL2XrhVDgob+jEImEXCLrmKTVQFtUu4aYOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ltUuAdt6ysyIvCBmOvbCte/Y6AM6ZP2kt+ygE0Fcca8UttWMp7rPq/o7vnt8?=
 =?us-ascii?Q?oZJrC/o6UXuqOmgi2Uzf48AXHwaTRXFp8nJHYgtXAFLrn7+jhSIoxf4s/Wh4?=
 =?us-ascii?Q?k1m8bo7ckPW5mKeFnpptvnNtM5+zrOvnoYIkEQsaLRkyOjrYUU4V746W/mHr?=
 =?us-ascii?Q?xAaXY1wGf5L6445HWwZrHYIk2zK5O2+zqOTJTwjWwU/euhgR5Fl6n+BpUXpo?=
 =?us-ascii?Q?zJakl5+KOdvfiFtHwvhHmAUjpCMamP3QK89lgsu01LmSEvwd6NJb5hnMBT6T?=
 =?us-ascii?Q?aQQZcTohM+VAR9/yN2xvofW30FDm4ttdR9cL+bg8C1tyntQSWs3nallDVBSp?=
 =?us-ascii?Q?TqY0JR0PVHeF+nMhpzerB1TQ3DkvDzl1NzmX+Q02kgrR5Ix8pIbAECG5m+O0?=
 =?us-ascii?Q?Px9Y09kb6QhnK0pKznHeFI4j+3pQJ+fIQeDeycGmsi6PdMiUFsoM8G9fHvIX?=
 =?us-ascii?Q?TZ/6P/QHA394WbTmRg9g63vhGRCaQ3oyDTialuywG7iYLHTn4nyzh/mUEcF5?=
 =?us-ascii?Q?kQi4DZR8CQs72/Uk/Y1fckblYWw8aA3nYOXi5W73bCWM6SxAl5GXDSq/KQfW?=
 =?us-ascii?Q?3B4PBtdTKdaO+2cWZaKaTUqKd2hSRzecO5tX5/Ax/t8DSULxU/u0JL1Z74mr?=
 =?us-ascii?Q?/GVwO9V+JdVZc0adJZTcw7cD5RME4z5ACfM8qZ5A+yKNz+MJAgNcMtg+v61C?=
 =?us-ascii?Q?zzcVCxOR1/CJwxvU4v/JDIyHuW/8x2tYTch1eKXg2daxmL2JiZ11rb9nP0uv?=
 =?us-ascii?Q?G9+RKfbqZXKjWspvTA7zjcs9fyrHX2HNLm0Gp45bi0G54Wtaih2K7XPosFMX?=
 =?us-ascii?Q?pC8C9iiETNBv4LuuufjzMba0ZUQpbur1QPegnsYVZ01xfSY53QXGy+42dZvC?=
 =?us-ascii?Q?s/3ZN3HoiFYDWNh67b6FCmfJMELL3maoivzgNnHaJ2uxsQ4Enx5kJlafQcbP?=
 =?us-ascii?Q?F3+6lgOwvIKCCdrHx0jpgWgHAtHZc6Y7LvBGQNothBPqP6yxdE0ff9QFDU/n?=
 =?us-ascii?Q?iGxqzFdHUVB11KHru8dgS2xDtlKh8BR5B0gmqdQQTZEPZ1q0ZuhLADuA3nOj?=
 =?us-ascii?Q?hCnbIYYpRKuk6POYBCUCFO4FYxSddPZZ92na2GAlu2Kj7WmiS3LpP5TGdZyb?=
 =?us-ascii?Q?oRpLyL9I5AsGzdcnyK+PPrPzaoWqJvTH7MMZolzifIFbYkwUhVetMGzBku3B?=
 =?us-ascii?Q?Zlxw7WbT1psNLjoKN20oDClzlBRxAOBgfPlBK1KLeEQEGfaiJKxSClHq1AU6?=
 =?us-ascii?Q?vLGyYSq/7S0zNrOQUNTUHjiNRFedL+Eeogv6+ORo5pp4xBNfzmR0HB4OwAAz?=
 =?us-ascii?Q?FXVRNEWVWwl1//vg/HFDk1ePGdJMl9MV113OJNbVtiO8YUm4D0vZdpCe2BJT?=
 =?us-ascii?Q?OFtjQyF+is3A5rAQ2+iyV94bo5PtQTxhzd6hjv+EBrKyMjY0nPdgGqN3JICA?=
 =?us-ascii?Q?BpQmv+JCalbhDiVTksiHyUt+VYTnexcraGEjgX294fYbp0hcrfJqozCaO8nn?=
 =?us-ascii?Q?isRVDYfOesL/l4eMOY5BQBgu0XDi+mRn+T86i1l8o1+sjX/2CeIvUHb+td2E?=
 =?us-ascii?Q?tWCgKoZVt7vlEXBAJQO1SxW+7tdjmCmFd/keWxKn/JZ1P9b5BdMZa3cUE0FV?=
 =?us-ascii?Q?M1doO78HE5lgn4bBmPZykRU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c3dc8d-9b18-448e-6672-08dddf3c1fe9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:19:08.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx+b9Xyr/pPDo/C6aUw5yrmcD4ajvDdUWBUJdYtjqraBSB85LUCQbYDgyFImHyVtD2J1DEhIotdKaL2O/3uRkBtMD9gecBffEbFCI95dBE8WgIbw8CzePRuP48hSIi17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049

Hi Biju,
Thank you for the patch.

On Thu, Aug 14, 2025 at 07:41:05PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
> SoC.
> 
> The GPT IP on these parts is similar to that on RZ/G2L but supports
> only 8 interrupts per channel and has multiple clocks and resets.
> Introduce a new compatible string `renesas,r9a09g047-gpt` for RZ/G3E.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 525 ++++++++++++------
>  1 file changed, 356 insertions(+), 169 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> index 13b807765a30..6250dbb200e7 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> @@ -58,11 +58,14 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
> -          - renesas,r9a07g054-gpt  # RZ/V2L
> -      - const: renesas,rzg2l-gpt
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
> +              - renesas,r9a07g054-gpt  # RZ/V2L
> +          - const: renesas,rzg2l-gpt
> +
> +      - const: renesas,r9a09g047-gpt  # RZ/G3E
>  
>    reg:
>      maxItems: 1
> @@ -71,179 +74,327 @@ properties:
>      const: 3
>  
>    interrupts:
> -    items:
> -      - description: GPT32E0.GTCCRA input capture/compare match
> -      - description: GPT32E0.GTCCRB input capture/compare
> -      - description: GPT32E0.GTCCRC compare match
> -      - description: GPT32E0.GTCCRD compare match
> -      - description: GPT32E0.GTCCRE compare match
> -      - description: GPT32E0.GTCCRF compare match
> -      - description: GPT32E0.GTADTRA compare match
> -      - description: GPT32E0.GTADTRB compare match
> -      - description: GPT32E0.GTCNT overflow/GTPR compare match
> -      - description: GPT32E0.GTCNT underflow
> -      - description: GPT32E1.GTCCRA input capture/compare match
> -      - description: GPT32E1.GTCCRB input capture/compare
> -      - description: GPT32E1.GTCCRC compare match
> -      - description: GPT32E1.GTCCRD compare match
> -      - description: GPT32E1.GTCCRE compare match
> -      - description: GPT32E1.GTCCRF compare match
> -      - description: GPT32E1.GTADTRA compare match
> -      - description: GPT32E1.GTADTRB compare match
> -      - description: GPT32E1.GTCNT overflow/GTPR compare match
> -      - description: GPT32E1.GTCNT underflow
> -      - description: GPT32E2.GTCCRA input capture/compare match
> -      - description: GPT32E2.GTCCRB input capture/compare
> -      - description: GPT32E2.GTCCRC compare match
> -      - description: GPT32E2.GTCCRD compare match
> -      - description: GPT32E2.GTCCRE compare match
> -      - description: GPT32E2.GTCCRF compare match
> -      - description: GPT32E2.GTADTRA compare match
> -      - description: GPT32E2.GTADTRB compare match
> -      - description: GPT32E2.GTCNT overflow/GTPR compare match
> -      - description: GPT32E2.GTCNT underflow
> -      - description: GPT32E3.GTCCRA input capture/compare match
> -      - description: GPT32E3.GTCCRB input capture/compare
> -      - description: GPT32E3.GTCCRC compare match
> -      - description: GPT32E3.GTCCRD compare match
> -      - description: GPT32E3.GTCCRE compare match
> -      - description: GPT32E3.GTCCRF compare match
> -      - description: GPT32E3.GTADTRA compare match
> -      - description: GPT32E3.GTADTRB compare match
> -      - description: GPT32E3.GTCNT overflow/GTPR compare match
> -      - description: GPT32E3.GTCNT underflow
> -      - description: GPT32E4.GTCCRA input capture/compare match
> -      - description: GPT32E4.GTCCRB input capture/compare
> -      - description: GPT32E4.GTCCRC compare match
> -      - description: GPT32E4.GTCCRD compare match
> -      - description: GPT32E4.GTCCRE compare match
> -      - description: GPT32E4.GTCCRF compare match
> -      - description: GPT32E4.GTADTRA compare match
> -      - description: GPT32E4.GTADTRB compare match
> -      - description: GPT32E4.GTCNT overflow/GTPR compare match
> -      - description: GPT32E4.GTCNT underflow
> -      - description: GPT32E5.GTCCRA input capture/compare match
> -      - description: GPT32E5.GTCCRB input capture/compare
> -      - description: GPT32E5.GTCCRC compare match
> -      - description: GPT32E5.GTCCRD compare match
> -      - description: GPT32E5.GTCCRE compare match
> -      - description: GPT32E5.GTCCRF compare match
> -      - description: GPT32E5.GTADTRA compare match
> -      - description: GPT32E5.GTADTRB compare match
> -      - description: GPT32E5.GTCNT overflow/GTPR compare match
> -      - description: GPT32E5.GTCNT underflow
> -      - description: GPT32E6.GTCCRA input capture/compare match
> -      - description: GPT32E6.GTCCRB input capture/compare
> -      - description: GPT32E6.GTCCRC compare match
> -      - description: GPT32E6.GTCCRD compare match
> -      - description: GPT32E6.GTCCRE compare match
> -      - description: GPT32E6.GTCCRF compare match
> -      - description: GPT32E6.GTADTRA compare match
> -      - description: GPT32E6.GTADTRB compare match
> -      - description: GPT32E6.GTCNT overflow/GTPR compare match
> -      - description: GPT32E6.GTCNT underflow
> -      - description: GPT32E7.GTCCRA input capture/compare match
> -      - description: GPT32E7.GTCCRB input capture/compare
> -      - description: GPT32E7.GTCCRC compare match
> -      - description: GPT32E7.GTCCRD compare match
> -      - description: GPT32E7.GTCCRE compare match
> -      - description: GPT32E7.GTCCRF compare match
> -      - description: GPT32E7.GTADTRA compare match
> -      - description: GPT32E7.GTADTRB compare match
> -      - description: GPT32E7.GTCNT overflow/GTPR compare match
> -      - description: GPT32E7.GTCNT underflow
> +    oneOf:
> +      - items:
> +          - description: GPT32E0.GTCCRA input capture/compare match
> +          - description: GPT32E0.GTCCRB input capture/compare
> +          - description: GPT32E0.GTCCRC compare match
> +          - description: GPT32E0.GTCCRD compare match
> +          - description: GPT32E0.GTCCRE compare match
> +          - description: GPT32E0.GTCCRF compare match
> +          - description: GPT32E0.GTADTRA compare match
> +          - description: GPT32E0.GTADTRB compare match
> +          - description: GPT32E0.GTCNT overflow/GTPR compare match
> +          - description: GPT32E0.GTCNT underflow
> +          - description: GPT32E1.GTCCRA input capture/compare match
> +          - description: GPT32E1.GTCCRB input capture/compare
> +          - description: GPT32E1.GTCCRC compare match
> +          - description: GPT32E1.GTCCRD compare match
> +          - description: GPT32E1.GTCCRE compare match
> +          - description: GPT32E1.GTCCRF compare match
> +          - description: GPT32E1.GTADTRA compare match
> +          - description: GPT32E1.GTADTRB compare match
> +          - description: GPT32E1.GTCNT overflow/GTPR compare match
> +          - description: GPT32E1.GTCNT underflow
> +          - description: GPT32E2.GTCCRA input capture/compare match
> +          - description: GPT32E2.GTCCRB input capture/compare
> +          - description: GPT32E2.GTCCRC compare match
> +          - description: GPT32E2.GTCCRD compare match
> +          - description: GPT32E2.GTCCRE compare match
> +          - description: GPT32E2.GTCCRF compare match
> +          - description: GPT32E2.GTADTRA compare match
> +          - description: GPT32E2.GTADTRB compare match
> +          - description: GPT32E2.GTCNT overflow/GTPR compare match
> +          - description: GPT32E2.GTCNT underflow
> +          - description: GPT32E3.GTCCRA input capture/compare match
> +          - description: GPT32E3.GTCCRB input capture/compare
> +          - description: GPT32E3.GTCCRC compare match
> +          - description: GPT32E3.GTCCRD compare match
> +          - description: GPT32E3.GTCCRE compare match
> +          - description: GPT32E3.GTCCRF compare match
> +          - description: GPT32E3.GTADTRA compare match
> +          - description: GPT32E3.GTADTRB compare match
> +          - description: GPT32E3.GTCNT overflow/GTPR compare match
> +          - description: GPT32E3.GTCNT underflow
> +          - description: GPT32E4.GTCCRA input capture/compare match
> +          - description: GPT32E4.GTCCRB input capture/compare
> +          - description: GPT32E4.GTCCRC compare match
> +          - description: GPT32E4.GTCCRD compare match
> +          - description: GPT32E4.GTCCRE compare match
> +          - description: GPT32E4.GTCCRF compare match
> +          - description: GPT32E4.GTADTRA compare match
> +          - description: GPT32E4.GTADTRB compare match
> +          - description: GPT32E4.GTCNT overflow/GTPR compare match
> +          - description: GPT32E4.GTCNT underflow
> +          - description: GPT32E5.GTCCRA input capture/compare match
> +          - description: GPT32E5.GTCCRB input capture/compare
> +          - description: GPT32E5.GTCCRC compare match
> +          - description: GPT32E5.GTCCRD compare match
> +          - description: GPT32E5.GTCCRE compare match
> +          - description: GPT32E5.GTCCRF compare match
> +          - description: GPT32E5.GTADTRA compare match
> +          - description: GPT32E5.GTADTRB compare match
> +          - description: GPT32E5.GTCNT overflow/GTPR compare match
> +          - description: GPT32E5.GTCNT underflow
> +          - description: GPT32E6.GTCCRA input capture/compare match
> +          - description: GPT32E6.GTCCRB input capture/compare
> +          - description: GPT32E6.GTCCRC compare match
> +          - description: GPT32E6.GTCCRD compare match
> +          - description: GPT32E6.GTCCRE compare match
> +          - description: GPT32E6.GTCCRF compare match
> +          - description: GPT32E6.GTADTRA compare match
> +          - description: GPT32E6.GTADTRB compare match
> +          - description: GPT32E6.GTCNT overflow/GTPR compare match
> +          - description: GPT32E6.GTCNT underflow
> +          - description: GPT32E7.GTCCRA input capture/compare match
> +          - description: GPT32E7.GTCCRB input capture/compare
> +          - description: GPT32E7.GTCCRC compare match
> +          - description: GPT32E7.GTCCRD compare match
> +          - description: GPT32E7.GTCCRE compare match
> +          - description: GPT32E7.GTCCRF compare match
> +          - description: GPT32E7.GTADTRA compare match
> +          - description: GPT32E7.GTADTRB compare match
> +          - description: GPT32E7.GTCNT overflow/GTPR compare match
> +          - description: GPT32E7.GTCNT underflow
> +      - items:
> +          - description: Input capture/compare match of the GTCCRA for channel 0 and 8
> +          - description: Input capture/compare match of the GTCCRB for channel 0 and 8
> +          - description: Compare match with the GTCCRC for channel 0 and 8
> +          - description: Compare match with the GTCCRD for channel 0 and 8
> +          - description: Compare match with the GTCCRE for channel 0 and 8
> +          - description: Compare match with the GTCCRF for channel 0 and 8
> +          - description: A and B both high interrupt for channel 0 and 8
> +          - description: A and B both low interrupt for channel 0 and 8
> +          - description: Input capture/compare match of the GTCCRA for channel 1 and 9
> +          - description: Input capture/compare match of the GTCCRB for channel 1 and 9
> +          - description: Compare match with the GTCCRC for channel 1 and 9
> +          - description: Compare match with the GTCCRD for channel 1 and 9
> +          - description: Compare match with the GTCCRE for channel 1 and 9
> +          - description: Compare match with the GTCCRF for channel 1 and 9
> +          - description: A and B both high interrupt for channel 1 and 9
> +          - description: A and B both low interrupt for channel 1 and 9
> +          - description: Input capture/compare match of the GTCCRA for channel 2 and 10
> +          - description: Input capture/compare match of the GTCCRB for channel 2 and 10
> +          - description: Compare match with the GTCCRC for channel 2 and 10
> +          - description: Compare match with the GTCCRD for channel 2 and 10
> +          - description: Compare match with the GTCCRE for channel 2 and 10
> +          - description: Compare match with the GTCCRF for channel 2 and 10
> +          - description: A and B both high interrupt for channel 2 and 10
> +          - description: A and B both low interrupt for channel 2 and 10
> +          - description: Input capture/compare match of the GTCCRA for channel 3 and 11
> +          - description: Input capture/compare match of the GTCCRB for channel 3 and 11
> +          - description: Compare match with the GTCCRC for channel 3 and 11
> +          - description: Compare match with the GTCCRD for channel 3 and 11
> +          - description: Compare match with the GTCCRE for channel 3 and 11
> +          - description: Compare match with the GTCCRF for channel 3 and 11
> +          - description: A and B both high interrupt for channel 3 and 11
> +          - description: A and B both low interrupt for channel 3 and 11
> +          - description: Input capture/compare match of the GTCCRA for channel 4 and 12
> +          - description: Input capture/compare match of the GTCCRB for channel 4 and 12
> +          - description: Compare match with the GTCCRC for channel 4 and 12
> +          - description: Compare match with the GTCCRD for channel 4 and 12
> +          - description: Compare match with the GTCCRE for channel 4 and 12
> +          - description: Compare match with the GTCCRF for channel 4 and 12
> +          - description: A and B both high interrupt for channel 4 and 12
> +          - description: A and B both low interrupt for channel 4 and 12
> +          - description: Input capture/compare match of the GTCCRA for channel 5 and 13
> +          - description: Input capture/compare match of the GTCCRB for channel 5 and 13
> +          - description: Compare match with the GTCCRC for channel 5 and 13
> +          - description: Compare match with the GTCCRD for channel 5 and 13
> +          - description: Compare match with the GTCCRE for channel 5 and 13
> +          - description: Compare match with the GTCCRF for channel 5 and 13
> +          - description: A and B both high interrupt for channel 5 and 13
> +          - description: A and B both low interrupt for channel 5 and 13
> +          - description: Input capture/compare match of the GTCCRA for channel 6 and 14
> +          - description: Input capture/compare match of the GTCCRB for channel 6 and 14
> +          - description: Compare match with the GTCCRC for channel 6 and 14
> +          - description: Compare match with the GTCCRD for channel 6 and 14
> +          - description: Compare match with the GTCCRE for channel 6 and 14
> +          - description: Compare match with the GTCCRF for channel 6 and 14
> +          - description: A and B both high interrupt for channel 6 and 14
> +          - description: A and B both low interrupt for channel 6 and 14
> +          - description: Input capture/compare match of the GTCCRA for channel 7 and 15
> +          - description: Input capture/compare match of the GTCCRB for channel 7 and 15
> +          - description: Compare match with the GTCCRC for channel 7 and 15
> +          - description: Compare match with the GTCCRD for channel 7 and 15
> +          - description: Compare match with the GTCCRE for channel 7 and 15
> +          - description: Compare match with the GTCCRF for channel 7 and 15
> +          - description: A and B both high interrupt for channel 7 and 15
> +          - description: A and B both low interrupt for channel 7 and 15
>  
>    interrupt-names:
> -    items:
> -      - const: ccmpa0
> -      - const: ccmpb0
> -      - const: cmpc0
> -      - const: cmpd0
> -      - const: cmpe0
> -      - const: cmpf0
> -      - const: adtrga0
> -      - const: adtrgb0
> -      - const: ovf0
> -      - const: unf0
> -      - const: ccmpa1
> -      - const: ccmpb1
> -      - const: cmpc1
> -      - const: cmpd1
> -      - const: cmpe1
> -      - const: cmpf1
> -      - const: adtrga1
> -      - const: adtrgb1
> -      - const: ovf1
> -      - const: unf1
> -      - const: ccmpa2
> -      - const: ccmpb2
> -      - const: cmpc2
> -      - const: cmpd2
> -      - const: cmpe2
> -      - const: cmpf2
> -      - const: adtrga2
> -      - const: adtrgb2
> -      - const: ovf2
> -      - const: unf2
> -      - const: ccmpa3
> -      - const: ccmpb3
> -      - const: cmpc3
> -      - const: cmpd3
> -      - const: cmpe3
> -      - const: cmpf3
> -      - const: adtrga3
> -      - const: adtrgb3
> -      - const: ovf3
> -      - const: unf3
> -      - const: ccmpa4
> -      - const: ccmpb4
> -      - const: cmpc4
> -      - const: cmpd4
> -      - const: cmpe4
> -      - const: cmpf4
> -      - const: adtrga4
> -      - const: adtrgb4
> -      - const: ovf4
> -      - const: unf4
> -      - const: ccmpa5
> -      - const: ccmpb5
> -      - const: cmpc5
> -      - const: cmpd5
> -      - const: cmpe5
> -      - const: cmpf5
> -      - const: adtrga5
> -      - const: adtrgb5
> -      - const: ovf5
> -      - const: unf5
> -      - const: ccmpa6
> -      - const: ccmpb6
> -      - const: cmpc6
> -      - const: cmpd6
> -      - const: cmpe6
> -      - const: cmpf6
> -      - const: adtrga6
> -      - const: adtrgb6
> -      - const: ovf6
> -      - const: unf6
> -      - const: ccmpa7
> -      - const: ccmpb7
> -      - const: cmpc7
> -      - const: cmpd7
> -      - const: cmpe7
> -      - const: cmpf7
> -      - const: adtrga7
> -      - const: adtrgb7
> -      - const: ovf7
> -      - const: unf7
> +    oneOf:
> +      - items:
> +          - const: ccmpa0
> +          - const: ccmpb0
> +          - const: cmpc0
> +          - const: cmpd0
> +          - const: cmpe0
> +          - const: cmpf0
> +          - const: adtrga0
> +          - const: adtrgb0
> +          - const: ovf0
> +          - const: unf0
> +          - const: ccmpa1
> +          - const: ccmpb1
> +          - const: cmpc1
> +          - const: cmpd1
> +          - const: cmpe1
> +          - const: cmpf1
> +          - const: adtrga1
> +          - const: adtrgb1
> +          - const: ovf1
> +          - const: unf1
> +          - const: ccmpa2
> +          - const: ccmpb2
> +          - const: cmpc2
> +          - const: cmpd2
> +          - const: cmpe2
> +          - const: cmpf2
> +          - const: adtrga2
> +          - const: adtrgb2
> +          - const: ovf2
> +          - const: unf2
> +          - const: ccmpa3
> +          - const: ccmpb3
> +          - const: cmpc3
> +          - const: cmpd3
> +          - const: cmpe3
> +          - const: cmpf3
> +          - const: adtrga3
> +          - const: adtrgb3
> +          - const: ovf3
> +          - const: unf3
> +          - const: ccmpa4
> +          - const: ccmpb4
> +          - const: cmpc4
> +          - const: cmpd4
> +          - const: cmpe4
> +          - const: cmpf4
> +          - const: adtrga4
> +          - const: adtrgb4
> +          - const: ovf4
> +          - const: unf4
> +          - const: ccmpa5
> +          - const: ccmpb5
> +          - const: cmpc5
> +          - const: cmpd5
> +          - const: cmpe5
> +          - const: cmpf5
> +          - const: adtrga5
> +          - const: adtrgb5
> +          - const: ovf5
> +          - const: unf5
> +          - const: ccmpa6
> +          - const: ccmpb6
> +          - const: cmpc6
> +          - const: cmpd6
> +          - const: cmpe6
> +          - const: cmpf6
> +          - const: adtrga6
> +          - const: adtrgb6
> +          - const: ovf6
> +          - const: unf6
> +          - const: ccmpa7
> +          - const: ccmpb7
> +          - const: cmpc7
> +          - const: cmpd7
> +          - const: cmpe7
> +          - const: cmpf7
> +          - const: adtrga7
> +          - const: adtrgb7
> +          - const: ovf7
> +          - const: unf7
> +      - items:
> +          - const: gtcia0
> +          - const: gtcib0
> +          - const: gtcic0
> +          - const: gtcid0
> +          - const: gtcie0
> +          - const: gtcif0
> +          - const: gtcih0
> +          - const: gtcil0
> +          - const: gtcia1
> +          - const: gtcib1
> +          - const: gtcic1
> +          - const: gtcid1
> +          - const: gtcie1
> +          - const: gtcif1
> +          - const: gtcih1
> +          - const: gtcil1
> +          - const: gtcia2
> +          - const: gtcib2
> +          - const: gtcic2
> +          - const: gtcid2
> +          - const: gtcie2
> +          - const: gtcif2
> +          - const: gtcih2
> +          - const: gtcil2
> +          - const: gtcia3
> +          - const: gtcib3
> +          - const: gtcic3
> +          - const: gtcid3
> +          - const: gtcie3
> +          - const: gtcif3
> +          - const: gtcih3
> +          - const: gtcil3
> +          - const: gtcia4
> +          - const: gtcib4
> +          - const: gtcic4
> +          - const: gtcid4
> +          - const: gtcie4
> +          - const: gtcif4
> +          - const: gtcih4
> +          - const: gtcil4
> +          - const: gtcia5
> +          - const: gtcib5
> +          - const: gtcic5
> +          - const: gtcid5
> +          - const: gtcie5
> +          - const: gtcif5
> +          - const: gtcih5
> +          - const: gtcil5
> +          - const: gtcia6
> +          - const: gtcib6
> +          - const: gtcic6
> +          - const: gtcid6
> +          - const: gtcie6
> +          - const: gtcif6
> +          - const: gtcih6
> +          - const: gtcil6
> +          - const: gtcia7
> +          - const: gtcib7
> +          - const: gtcic7
> +          - const: gtcid7
> +          - const: gtcie7
> +          - const: gtcif7
> +          - const: gtcih7
> +          - const: gtcil7
>  
>    clocks:
> -    maxItems: 1
> +    items:
> +      - description: Core clock (PCLKD)
> +      - description: Bus clock (PCLKA)
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: bus
>  
>    power-domains:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    items:
> +      - description: Reset for bus clock (PCLKA/PCLKD)
> +      - description: Reset for core clock (PCLKD)
> +    minItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: rst_p
> +      - const: rst_s
>  
>  required:
>    - compatible
> @@ -257,6 +408,42 @@ required:
>  allOf:
>    - $ref: pwm.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-gpt
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +        resets:
> +          minItems: 2
> +        interrupts:
> +          maxItems: 64
> +        interrupt-names:
> +          maxItems: 64
> +
> +      required:
> +        - clock-names
> +        - reset-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rzg2l-gpt
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        resets:
> +          maxItems: 1
> +        interrupts:
> +          minItems: 80
> +        interrupt-names:
> +          minItems: 80
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.43.0
> 

