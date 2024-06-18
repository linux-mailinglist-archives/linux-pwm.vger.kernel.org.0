Return-Path: <linux-pwm+bounces-2535-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D590DAE9
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8371F216FA
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F540144300;
	Tue, 18 Jun 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="zctgagfl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2102.outbound.protection.outlook.com [40.107.135.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6E1CAB3;
	Tue, 18 Jun 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732788; cv=fail; b=uGlS/pcGAxGoSrMAPJA2LdaqWu0XubXVODlIjSze48v7dv+C7Bn4+jinBnm/jmSq8D9QuWODHamorh4JvhtnmCKGviUZ2d+5yq0xo3WBeNC7aX3HxPQ0Wt10EiqOW3wSxVrm3VFXY6cPiYwm1wcUNA4FJ5cwEUkodEWGDQBb7bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732788; c=relaxed/simple;
	bh=WJ9cP3p7dNEWq+ZVxrBu8zNku35SiUPwY6VOSD8of7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=faBAJsv/rtNpvvYKH/wRIRYlez071CGM0Ohc0NBf1NYnzLp4rq5I/OO7LKkpmgqPmgh1WlegJiJ7o1H1Pm++niNSs94li/oajTcIS71gVTGdIIJ2xCLUtT3iVwhZMSC9dhB30ZNXS1GfXBO7SdjAFdZGFNWGuuGKCu4F4ud6QoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=zctgagfl; arc=fail smtp.client-ip=40.107.135.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAxLTiUxbYfMGtTgfStJw458d2Nnq1QNnWV+unIEmm3XRj0XS0Hl8RYB/ZFgRX2TF7CXhJUU8flo57hLoWlFmWIU96EmAKg8zGnglnSrdpwzJLpng69aOwb6+ohJ5wV0ocPV1EGpWpM6aHWtN88WSkMb395imFO/nxjQZnLo6/9baOuRAgLpVSFQxsiHXTJGk/eH7SXrOKh+sTFz7NTE3dChwD5qxOTMYUIg6YcLb6fE8VzJrv99dgq+CcRm8ZnkYYfOrkC9dyxmBFrg6V6M8f8/ptYoe38Nu3gR8QJpH/61H7VahAZqYUEoRi9wjZzj54lV/44NBCqIKfbXBaGWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2inw2oGnIL16eikzTA3tWsTPiA72EwPRKalL1jxCEwc=;
 b=MhAOhTKWYEiaHTlwtUN1dYPByLXNVXJS9JesNIj/KrVZDuemkZlBqthHe91gAtvi0In01WT1tFzw7cybE4jJYgvc2hfzabyKXs+wh54W0sST5hlurzJZLzOqKrp750hNW19ZdjuNdS8m5pHfMI3+G82p4sBINhWsBWf47vFSCXNuu+zIwR47V6zxqU/2It2kSSt3GwkCJiZOqjbB9MopfHfJ09RCqyFMtDXVf8EFjsD9TuuGWFk/VHgjumyqOBmmCAwekSZ770KnI8f5n1mQ/XQipf89r1GCoBUZlx/rHwv1gSOx6NPhXjiMS2NES5bJaJuvJFVYrsAEGVs9xE2bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2inw2oGnIL16eikzTA3tWsTPiA72EwPRKalL1jxCEwc=;
 b=zctgagflph+OE5NvpLt6qj+mvamkTJA45K18vYCew/oR3a+5q57Obvizc/cItck/DvbbARsfB9eSYFf0dT9jxTji4fPUYJfkqGt5lBn2D3tC2bw7iup/xYgu6G7EZJagKz3iO273omgkdIPknGXHUfC+6g7kuv8KrNzWYld+FbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from BEUP281MB3513.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9a::8) by
 BEYP281MB3953.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 17:46:22 +0000
Received: from BEUP281MB3513.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ec4:ae75:3f57:1bd4]) by BEUP281MB3513.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ec4:ae75:3f57:1bd4%4]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 17:46:22 +0000
Date: Tue, 18 Jun 2024 19:46:20 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	William Breathitt Gray <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mfd: stm32-timers: Unify alignment of register
 definition
Message-ID: <kydsb3svcr7thejn22agykunswjqt5sx6xunrbqsmymhlp5lsc@bjwvdoqbqwdm>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
 <4c4ca7a4c1862e4683f83d19a1e5a75526aeb501.1718352022.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4c4ca7a4c1862e4683f83d19a1e5a75526aeb501.1718352022.git.u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To BEUP281MB3513.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9a::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEUP281MB3513:EE_|BEYP281MB3953:EE_
X-MS-Office365-Filtering-Correlation-Id: aaff017c-8928-43ec-b531-08dc8fbe90ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|1800799021|27256014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?/OxRsUB9sZ+aJYAj4cT8pRn8upVUd3z9IO55sMRUQfmnFQv9R6N7gQ3k1P?=
 =?iso-8859-1?Q?DwBh3x98BLjPu+r21SkP15R+u/yyczxedMrkzWtsmAMRuFLRBc7A0lzJOw?=
 =?iso-8859-1?Q?MuqciSImRfFz252vnTN3tFXq4o6Uzzunu0n34gu40GSV/Ch1wIves9aMAd?=
 =?iso-8859-1?Q?P9k6KHWShgzyCEFnoildXk0xhZwQIjj3dW49wjwOB23RJ0mGJSxbuhe4zA?=
 =?iso-8859-1?Q?c2ZqqqKsulMLIDkpYVoCLDtXkF92+tJFYR8he1EuGvOyCpU1VlmRebHwKS?=
 =?iso-8859-1?Q?wSqqilMTejr8FBCfEo+Xkdfq8/ZKV2/Eojek0/ZVbSXh2vr/g9u7JkTj17?=
 =?iso-8859-1?Q?7rgJuLJsUIYieQBl5tk0CtlAw0+DieFwrF5/eyShMEp6ITbzR0/FG0zUEy?=
 =?iso-8859-1?Q?/RkfgHzHlEZGKIZisT+fFc6turAd3z2srFqeclZRlMsRbk+Lk6zyvcR+yO?=
 =?iso-8859-1?Q?85LzbQdiCGfmQGBh+BT2krQVIY5b1MKVY2IKd/lNLL8EKiylveqD0IG68V?=
 =?iso-8859-1?Q?p7hl7J3E1+O6dX4wrK4Z2MGddHqxKYWY5pBwDz4uf6VClmIhLHIfGwg9Wx?=
 =?iso-8859-1?Q?kBEM6h7FR6IkKeQQcNtf5xjMLIkhGiKuJ2fkXvtASsWPM611fI6a38Zo9H?=
 =?iso-8859-1?Q?DNwz79Oba2EcZ8mU1cp3EI46tZUixRIqWA4QfmqncTVAVCW05bqKVxsYIr?=
 =?iso-8859-1?Q?zSrns0Zdcp2MYRw/ak85l+WwWMwg/Kqwl8GIeUnVEHICYlQgY1L6tW1jTQ?=
 =?iso-8859-1?Q?eaa/V2VQDJLot6x/m4EyYJyspr1Bq/LCwoCJrfyXJ4RUTX5wG6DhabDHcM?=
 =?iso-8859-1?Q?yGuyyif20P685VX1fC6Ix63yiaCqaxlmCJ1OXF5bLp3gaKVhzVwc1qa5dk?=
 =?iso-8859-1?Q?K5Gna7UBoiU4N0ggflmbZAAU8ozQGQ5nLYBRgfRB/UHhbIgqIuQ/KsTfhq?=
 =?iso-8859-1?Q?od84QEiDIucz9KqXrnxohjAkhPzNubd3zxsY+uqGZNsbPfXOnjKAtUDcEZ?=
 =?iso-8859-1?Q?nLBl/EkQg+7PkxotqFvBF4c5Pk4w0crW08hOU2+S9dAQayL44LlvNbJmB7?=
 =?iso-8859-1?Q?dNrjgdYNBz7Pyk/HXO1P4nF/PnUh6m0vMDC4Ofwzlq1rE6YUX9fbfeAZEz?=
 =?iso-8859-1?Q?ZnF7EMze3spefuZaAjTi7jWoAZ99wQLdQD4QdDIYd4iEcQK6tDq5As8IIw?=
 =?iso-8859-1?Q?9/IB7Wj/QMSVKy46QFbf/g1YWW6oVdORMDTAmv+O/I/Fv9DH4T/kYhkq+7?=
 =?iso-8859-1?Q?G7Tf8Difz4DN5UstsqUZqsrH7ulPmQhCtYuizykESQUwP5tROxt628MTNw?=
 =?iso-8859-1?Q?NxSi0pUFOypef0Mwx7HSOMDrhEexNLFrwcF/Z0hcO76mKE+SNL2GGxCjv+?=
 =?iso-8859-1?Q?DSuIeyOkTQ7E5wYKIdz8WlyllEfK7+ceJY3/3nK+imZbVTm/KMycM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3513.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(27256014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Hj3n1DUoFitcdbp19HVVc2leRk8OcY3bqrmpugmB/p8OyZLyay1SD+Bq8N?=
 =?iso-8859-1?Q?aTxrRMFnEeaCN0LBA+zG7c8Yz+SDcLzDuy5rvizoDV3/uTwDeVu7eN68kV?=
 =?iso-8859-1?Q?apWwS+CWYXvcrS3+U1cB+G97PaGvDJORqtQWNnDZ0x5mjMRzPPPAA20P8V?=
 =?iso-8859-1?Q?a/qMSgozPcTfTOvxVAx6al+scpzF/4tqUu1OJKBHIEp3SMX6Kwo8oS2CFz?=
 =?iso-8859-1?Q?ZPKhCqKd1CJVDiyuKs7CCqoAstuR6pGFPMfkaU4yNYnNhgwLBg9yOCukzq?=
 =?iso-8859-1?Q?QYluBH80iq+n1YFPmNuOklp7T3GPfCBHxRKL+v5O0n6Ng6NajPPZYIJZAs?=
 =?iso-8859-1?Q?EhRuV8KQtFERfLt1cRqqJLDI6MzVioD4Z31mj7KSIsWz1efD4DvTyUwkgK?=
 =?iso-8859-1?Q?OOQjkwRTufH9lNUTR42fsA+1r0Xo6zvy/Qxv3rBjNV7eCAJ7rSBLcIvmvp?=
 =?iso-8859-1?Q?e0RMYQSFd3HPZ9+TdM/QRckGFWkjMWAudGN0+mXqydcjwY3N4pZehIT2v5?=
 =?iso-8859-1?Q?vc9zQBkoLbsrIZG9PBw1mmMtoP48GRYcYT39CM0UGkdL6Z++S4/8Q/poOU?=
 =?iso-8859-1?Q?RpepGSKaHkAxEGHAeyIkfXY4BA0JuqG6jLEvBfkel6q3QWscwLzidsIP7+?=
 =?iso-8859-1?Q?7j/MyyxeVIjjfHkMwzQeU8AWlYgy89SfP3OncBKdpOX3XvGsMIMIc39G+0?=
 =?iso-8859-1?Q?k1HxNzCQm34E4BIhaUMoXNdNG5fMNvjK+qfW6xgGAjyd/Zq0V7B4SUKDFB?=
 =?iso-8859-1?Q?aBmxSZ5HBcPClNv9+tinoYYg43RX0zK5NLx9fJ2RM69DRgAcM+tqs8LlGX?=
 =?iso-8859-1?Q?TvUnF+r0+UATZUdG5ctm19TBvoDHdt1qmrnMBIubQfoZ1Mo/xdgUsDRL3S?=
 =?iso-8859-1?Q?YQogn6GjkGI3XS5mAl1NplyeqpnjQb7BMMDypyg1PfrUpsEPYIRO1wD89d?=
 =?iso-8859-1?Q?EDGowKGsPAnnpKIuHwVGXgjc66dbYTplSVaceiI3kBBzgt5xZbLslyK93w?=
 =?iso-8859-1?Q?uR+O5Qtc2E58LIUARRadDmDlvHa8xQ9g5MPkuvlvax+eYbAWTJRZIzy29t?=
 =?iso-8859-1?Q?oon7txzOn7+XlEarZLVvkbZuCJ9lWSQRexHhb9z7fzJ67S+ufwgx2tRo/X?=
 =?iso-8859-1?Q?vFt4VOx+cziL801heGJmtOFBjpCOXkKFUhfL4FZogkMsfljL762B+ezKhb?=
 =?iso-8859-1?Q?UfrHncw9WccfmLuuutJV3FRgICb9XcJuLAdaXWUz1wmP8BtXrBJp38w/dP?=
 =?iso-8859-1?Q?pyv/q9Gll9EiELcB0nNIPNdKjq/Cx94EO9MOC+plKAAIDso5FhKMR041ee?=
 =?iso-8859-1?Q?HNX462Wp2jZaDlinzlmPZo2EFuxzScMuZdgiEyksJ3nmXic1Br/yZ9W6kJ?=
 =?iso-8859-1?Q?tKUyZtgdXSJx9dgqZ2zlhpX1Zb8mdooz5rjSACjaoi9UKGI+HEEItJy1hE?=
 =?iso-8859-1?Q?lALS8ySCYyZkCom8XXUk0lBcZtO9iMqdvSzp+KXuV1kU5lC9vBrh7pB7dL?=
 =?iso-8859-1?Q?Di7CxsUmiNoeWOhOcocbR+l6zHVFV1Ywc8eglq57aqoaVvMxkvYDH7g4QC?=
 =?iso-8859-1?Q?Z61LvhuJsvN3ywgZ1HfV0NUPsDdql4BjWe+d4CuvS+HSdxGRYkeT7fhw03?=
 =?iso-8859-1?Q?wKUFZiBVsDSWPJqZ+XmwxLfKjOWv8+8qFb?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aaff017c-8928-43ec-b531-08dc8fbe90ec
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3513.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:46:21.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz8ubUmZy1n6s8HCfQ+J54DCUFKnFuPn4Mi0VuGoyzDatsSeGYim7rk2+V296YkTX5vy3tYZbIot16sTA2Fl+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3953

Hi Uwe,

On Fri, Jun 14, 2024 at 10:10:11AM +0200, Uwe Kleine-K=F6nig wrote:
> Ust tabs consistently for indention and properly align register names,

Litte typo here.

s/Ust/Use/

> values and comments. This improves readability (at least for my eyes).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  include/linux/mfd/stm32-timers.h | 170 +++++++++++++++----------------
>  1 file changed, 85 insertions(+), 85 deletions(-)
>=20
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-t=
imers.h
> index 9eb17481b07f..5794110b2b28 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -12,97 +12,97 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/regmap.h>
> =20
> -#define TIM_CR1		0x00	/* Control Register 1      */
> -#define TIM_CR2		0x04	/* Control Register 2      */
> -#define TIM_SMCR	0x08	/* Slave mode control reg  */
> -#define TIM_DIER	0x0C	/* DMA/interrupt register  */
> -#define TIM_SR		0x10	/* Status register	   */
> -#define TIM_EGR		0x14	/* Event Generation Reg    */
> -#define TIM_CCMR1	0x18	/* Capt/Comp 1 Mode Reg    */
> -#define TIM_CCMR2	0x1C	/* Capt/Comp 2 Mode Reg    */
> -#define TIM_CCER	0x20	/* Capt/Comp Enable Reg    */
> -#define TIM_CNT		0x24	/* Counter		   */
> -#define TIM_PSC		0x28	/* Prescaler               */
> -#define TIM_ARR		0x2c	/* Auto-Reload Register    */
> -#define TIM_CCR1	0x34	/* Capt/Comp Register 1    */
> -#define TIM_CCR2	0x38	/* Capt/Comp Register 2    */
> -#define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
> -#define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
> -#define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
> -#define TIM_DCR		0x48	/* DMA control register    */
> -#define TIM_DMAR	0x4C	/* DMA register for transfer */
> -#define TIM_TISEL	0x68	/* Input Selection         */
> +#define TIM_CR1		0x00			/* Control Register 1			*/
> +#define TIM_CR2		0x04			/* Control Register 2			*/
> +#define TIM_SMCR	0x08			/* Slave mode control reg		*/
> +#define TIM_DIER	0x0C			/* DMA/interrupt register		*/
> +#define TIM_SR		0x10			/* Status register			*/
> +#define TIM_EGR		0x14			/* Event Generation Reg			*/
> +#define TIM_CCMR1	0x18			/* Capt/Comp 1 Mode Reg			*/
> +#define TIM_CCMR2	0x1C			/* Capt/Comp 2 Mode Reg			*/
> +#define TIM_CCER	0x20			/* Capt/Comp Enable Reg			*/
> +#define TIM_CNT		0x24			/* Counter				*/
> +#define TIM_PSC		0x28			/* Prescaler				*/
> +#define TIM_ARR		0x2c			/* Auto-Reload Register			*/
> +#define TIM_CCR1	0x34			/* Capt/Comp Register 1			*/
> +#define TIM_CCR2	0x38			/* Capt/Comp Register 2			*/
> +#define TIM_CCR3	0x3C			/* Capt/Comp Register 3			*/
> +#define TIM_CCR4	0x40			/* Capt/Comp Register 4			*/
> +#define TIM_BDTR	0x44			/* Break and Dead-Time Reg		*/
> +#define TIM_DCR		0x48			/* DMA control register			*/
> +#define TIM_DMAR	0x4C			/* DMA register for transfer		*/
> +#define TIM_TISEL	0x68			/* Input Selection			*/
> =20
> -#define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
> -#define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
> -#define TIM_CR1_ARPE	BIT(7)	/* Auto-reload Preload Ena */
> -#define TIM_CR2_MMS	(BIT(4) | BIT(5) | BIT(6)) /* Master mode selection =
*/
> -#define TIM_CR2_MMS2	GENMASK(23, 20) /* Master mode selection 2 */
> -#define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection =
*/
> -#define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
> -#define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
> -#define TIM_DIER_CC1IE	BIT(1)  /* CC1 Interrupt Enable    */
> -#define TIM_DIER_CC2IE	BIT(2)  /* CC2 Interrupt Enable    */
> -#define TIM_DIER_CC3IE	BIT(3)  /* CC3 Interrupt Enable    */
> -#define TIM_DIER_CC4IE	BIT(4)  /* CC4 Interrupt Enable    */
> -#define TIM_DIER_CC_IE(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt e=
nable */
> -#define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
> -#define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
> -#define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
> -#define TIM_DIER_CC3DE	BIT(11) /* CC3 DMA request Enable  */
> -#define TIM_DIER_CC4DE	BIT(12) /* CC4 DMA request Enable  */
> -#define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
> -#define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
> -#define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
> -#define TIM_SR_CC_IF(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt fla=
g */
> -#define TIM_EGR_UG	BIT(0)	/* Update Generation       */
> -#define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
> -#define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
> -#define TIM_CCMR_CC1S		(BIT(0) | BIT(1)) /* Capture/compare 1 sel */
> -#define TIM_CCMR_IC1PSC		GENMASK(3, 2)	/* Input capture 1 prescaler */
> -#define TIM_CCMR_CC2S		(BIT(8) | BIT(9)) /* Capture/compare 2 sel */
> -#define TIM_CCMR_IC2PSC		GENMASK(11, 10)	/* Input capture 2 prescaler */
> -#define TIM_CCMR_CC1S_TI1	BIT(0)	/* IC1/IC3 selects TI1/TI3 */
> -#define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
> -#define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
> -#define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
> -#define TIM_CCMR_CC3S		(BIT(0) | BIT(1)) /* Capture/compare 3 sel */
> -#define TIM_CCMR_CC4S		(BIT(8) | BIT(9)) /* Capture/compare 4 sel */
> -#define TIM_CCMR_CC3S_TI3	BIT(0)	/* IC3 selects TI3 */
> -#define TIM_CCMR_CC4S_TI4	BIT(8)	/* IC4 selects TI4 */
> -#define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
> -#define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
> -#define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
> -#define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
> -#define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
> -#define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
> -#define TIM_CCER_CC2NP	BIT(7)	/* Capt/Comp 2N Polarity   */
> -#define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
> -#define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
> -#define TIM_CCER_CC3NP	BIT(11)	/* Capt/Comp 3N Polarity   */
> -#define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
> -#define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
> -#define TIM_CCER_CC4NP	BIT(15)	/* Capt/Comp 4N Polarity   */
> -#define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
> -#define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
> -#define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
> -#define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
> -#define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
> -#define TIM_BDTR_BKF(x)	(0xf << (16 + (x) * 4))
> -#define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
> -#define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
> +#define TIM_CR1_CEN		BIT(0)					/* Counter Enable				*/
> +#define TIM_CR1_DIR		BIT(4)					/* Counter Direction				*/
> +#define TIM_CR1_ARPE		BIT(7)					/* Auto-reload Preload Ena			*/
> +#define TIM_CR2_MMS		(BIT(4) | BIT(5) | BIT(6))		/* Master mode selectio=
n			*/
> +#define TIM_CR2_MMS2		GENMASK(23, 20)				/* Master mode selection 2			*/
> +#define TIM_SMCR_SMS		(BIT(0) | BIT(1) | BIT(2))		/* Slave mode selectio=
n				*/
> +#define TIM_SMCR_TS		(BIT(4) | BIT(5) | BIT(6))		/* Trigger selection			=
	*/
> +#define TIM_DIER_UIE		BIT(0)					/* Update interrupt				*/
> +#define TIM_DIER_CC1IE		BIT(1)					/* CC1 Interrupt Enable				*/
> +#define TIM_DIER_CC2IE		BIT(2)					/* CC2 Interrupt Enable				*/
> +#define TIM_DIER_CC3IE		BIT(3)					/* CC3 Interrupt Enable				*/
> +#define TIM_DIER_CC4IE		BIT(4)					/* CC4 Interrupt Enable				*/
> +#define TIM_DIER_CC_IE(x)	BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrup=
t enable		*/
> +#define TIM_DIER_UDE		BIT(8)					/* Update DMA request Enable			*/
> +#define TIM_DIER_CC1DE		BIT(9)					/* CC1 DMA request Enable			*/
> +#define TIM_DIER_CC2DE		BIT(10)					/* CC2 DMA request Enable			*/
> +#define TIM_DIER_CC3DE		BIT(11)					/* CC3 DMA request Enable			*/
> +#define TIM_DIER_CC4DE		BIT(12)					/* CC4 DMA request Enable			*/
> +#define TIM_DIER_COMDE		BIT(13)					/* COM DMA request Enable			*/
> +#define TIM_DIER_TDE		BIT(14)					/* Trigger DMA request Enable			*/
> +#define TIM_SR_UIF		BIT(0)					/* Update interrupt flag			*/
> +#define TIM_SR_CC_IF(x)		BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt=
 flag		*/
> +#define TIM_EGR_UG		BIT(0)					/* Update Generation				*/
> +#define TIM_CCMR_PE		BIT(3)					/* Channel Preload Enable			*/
> +#define TIM_CCMR_M1		(BIT(6) | BIT(5))			/* Channel PWM Mode 1				*/
> +#define TIM_CCMR_CC1S		(BIT(0) | BIT(1))			/* Capture/compare 1 sel			*/
> +#define TIM_CCMR_IC1PSC		GENMASK(3, 2)				/* Input capture 1 prescaler		=
	*/
> +#define TIM_CCMR_CC2S		(BIT(8) | BIT(9))			/* Capture/compare 2 sel			*/
> +#define TIM_CCMR_IC2PSC		GENMASK(11, 10)				/* Input capture 2 prescaler=
			*/
> +#define TIM_CCMR_CC1S_TI1	BIT(0)					/* IC1/IC3 selects TI1/TI3			*/
> +#define TIM_CCMR_CC1S_TI2	BIT(1)					/* IC1/IC3 selects TI2/TI4			*/
> +#define TIM_CCMR_CC2S_TI2	BIT(8)					/* IC2/IC4 selects TI2/TI4			*/
> +#define TIM_CCMR_CC2S_TI1	BIT(9)					/* IC2/IC4 selects TI1/TI3			*/
> +#define TIM_CCMR_CC3S		(BIT(0) | BIT(1))			/* Capture/compare 3 sel			*/
> +#define TIM_CCMR_CC4S		(BIT(8) | BIT(9))			/* Capture/compare 4 sel			*/
> +#define TIM_CCMR_CC3S_TI3	BIT(0)					/* IC3 selects TI3				*/
> +#define TIM_CCMR_CC4S_TI4	BIT(8)					/* IC4 selects TI4				*/
> +#define TIM_CCER_CC1E		BIT(0)					/* Capt/Comp 1  out Ena				*/
> +#define TIM_CCER_CC1P		BIT(1)					/* Capt/Comp 1  Polarity			*/
> +#define TIM_CCER_CC1NE		BIT(2)					/* Capt/Comp 1N out Ena				*/
> +#define TIM_CCER_CC1NP		BIT(3)					/* Capt/Comp 1N Polarity			*/
> +#define TIM_CCER_CC2E		BIT(4)					/* Capt/Comp 2  out Ena				*/
> +#define TIM_CCER_CC2P		BIT(5)					/* Capt/Comp 2  Polarity			*/
> +#define TIM_CCER_CC2NP		BIT(7)					/* Capt/Comp 2N Polarity			*/
> +#define TIM_CCER_CC3E		BIT(8)					/* Capt/Comp 3  out Ena				*/
> +#define TIM_CCER_CC3P		BIT(9)					/* Capt/Comp 3  Polarity			*/
> +#define TIM_CCER_CC3NP		BIT(11)					/* Capt/Comp 3N Polarity			*/
> +#define TIM_CCER_CC4E		BIT(12)					/* Capt/Comp 4  out Ena				*/
> +#define TIM_CCER_CC4P		BIT(13)					/* Capt/Comp 4  Polarity			*/
> +#define TIM_CCER_CC4NP		BIT(15)					/* Capt/Comp 4N Polarity			*/
> +#define TIM_CCER_CCXE		(BIT(0) | BIT(4) | BIT(8) | BIT(12))
> +#define TIM_BDTR_BKE(x)		BIT(12 + (x) * 12)			/* Break input enable				*=
/
> +#define TIM_BDTR_BKP(x)		BIT(13 + (x) * 12)			/* Break input polarity			=
	*/
> +#define TIM_BDTR_AOE		BIT(14)					/* Automatic Output Enable			*/
> +#define TIM_BDTR_MOE		BIT(15)					/* Main Output Enable				*/
> +#define TIM_BDTR_BKF(x)		(0xf << (16 + (x) * 4))
> +#define TIM_DCR_DBA		GENMASK(4, 0)				/* DMA base addr				*/
> +#define TIM_DCR_DBL		GENMASK(12, 8)				/* DMA burst len				*/
> =20
> -#define MAX_TIM_PSC		0xFFFF
> -#define MAX_TIM_ICPSC		0x3
> -#define TIM_CR2_MMS_SHIFT	4
> -#define TIM_CR2_MMS2_SHIFT	20
> +#define MAX_TIM_PSC				0xFFFF
> +#define MAX_TIM_ICPSC				0x3
> +#define TIM_CR2_MMS_SHIFT			4
> +#define TIM_CR2_MMS2_SHIFT			20
>  #define TIM_SMCR_SMS_SLAVE_MODE_DISABLED	0 /* counts on internal clock w=
hen CEN=3D1 */
>  #define TIM_SMCR_SMS_ENCODER_MODE_1		1 /* counts TI1FP1 edges, depending=
 on TI2FP2 level */
>  #define TIM_SMCR_SMS_ENCODER_MODE_2		2 /* counts TI2FP2 edges, depending=
 on TI1FP1 level */
>  #define TIM_SMCR_SMS_ENCODER_MODE_3		3 /* counts on both TI1FP1 and TI2F=
P2 edges */
> -#define TIM_SMCR_TS_SHIFT	4
> -#define TIM_BDTR_BKF_MASK	0xF
> -#define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
> +#define TIM_SMCR_TS_SHIFT			4
> +#define TIM_BDTR_BKF_MASK			0xF
> +#define TIM_BDTR_BKF_SHIFT(x)			(16 + (x) * 4)
> =20
>  enum stm32_timers_dmas {
>  	STM32_TIMERS_DMA_CH1,
> --=20
> 2.43.0
>=20
>=20

Best regards
Thorsten

