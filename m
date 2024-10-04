Return-Path: <linux-pwm+bounces-3474-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E799116A
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A81F2103D
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441591B4F3E;
	Fri,  4 Oct 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b/eqFec8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851781B4F02;
	Fri,  4 Oct 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077129; cv=fail; b=BGFCSCxKzHfPfWxEoZKR4DROJbDQm16Tbpxr04tXSmp5jJWFj6Xk17kNdVu0W2+Ig1VkI5hvJ9K/FJYe+LkGbweKul53FivpWrWpf7o/TdU2ZFy/G3mmksd+/lr0iM79XQQ3j6jyGgl/gaOZvAMwq4pMJCnaQ4UZjEmYlM95kek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077129; c=relaxed/simple;
	bh=XwoQW15HPOMj1eSCHCUBAohR3dh0+pHkahAwHJliMTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sx5dpQz9aHj7ta08sn+PETj6ZobcVky+E1X0XKG+H17huL36yM2c5nPyGJfSNyZ6phntXWKRMvR6bikiteudPipRGrwM5NJKaDc8a6rwKosfrOpFC8AOMBjB3N2Gq/3+jIKOsDSJ9xHP70vU/4ZVGYZOfVMdDoztNTG3GwXui/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b/eqFec8; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGFKhXbSBpyWoV2OSZQGL1ESxin41zhi2Qb01C31ILqpDQIaS1Q7ahs2qtSiPEdJL01zmdjzUqjotwa3oOtDZNqQLsQng6cn6MQBxBsObZ04rQJF/eB+N90//6jQfjLNwLMBnb/epFm9z9S2/zli/c+Q8Mbz7AIkbNwGfQNScg+jjqTZuFu+aqfDhMvDx2cEs5wn4hwAgTrh5WKQCG9mgpL6a2ny6NVbl00THx/q6MJK7IHCV7EUcHxhLpZv+uCkkGD3hWrdonuZQFY1WWG43t2ELFzABOcglJkOEvkd97PCBMTihi1bjtEBNXbNzpdoOfjyYoX4my8LB0qaWZuJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89aPl0rCmnp4UgdtJA8DRH7fE/W8rpJFyt2fYer9Kyk=;
 b=dFENxt7+nTTA2XKS8wX5XM5o8GAHnhv3YRycY6WrbLm7qZscxeuPUIPkCIlpFsUE+qsRnW6X+dSrv/gEgKIaVnEXjwRKN08rfCQgO9gngFh7GFN7vqrS57hJofvW3bgf2aXq1YZfdL/t82F8SIFLp+T71rNwUiZI7bM1uTAlgMJqJqHfOAjSci+4BmjtvWduuPK+2Wfp9LPZjxvWBZek1YpZHmEQiKouIhIWYFml/m9otj+dYR8TmQBhdc5NNARuAcSCuEyznV0fjigURrtiFSEL5r/eIovXxnC+wfk58wzEMQBs/4BKuwZaIsYzqGrjz82YdBxYeHBfV/jni/jAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89aPl0rCmnp4UgdtJA8DRH7fE/W8rpJFyt2fYer9Kyk=;
 b=b/eqFec8TdKNYFZ89X/DwpESOLp+s5lXkh5JhC8ZKkEIh3viE4aiR90p63H8rblLacEHx5iDMSf50tovSFvpq0VdndSlyMOoJbB39Vy5zh4GcLc/pg7EjDXkan4yGL5GXewhUQU1OQBiktbTVVVt29vEDcY8Dw7zev8v6mrfsSaeK1GOskXN5TnqIfzLwjEiDss8MaFiB6yTP1aEE3OxL8WvRfpx3UZe/6kU7GiYONlmHJbssBR7ok6bwHIB75QLpdCArPZo7Y1gh08byH7DvARYG1EPqDF2rLTqcJmt2tBIEYbR9saW5dJri0DeDsHH9pIlEHsiX8GLDtapn/6G0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10763.eurprd04.prod.outlook.com (2603:10a6:800:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 21:25:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 21:25:23 +0000
Date: Fri, 4 Oct 2024 17:25:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: marex@denx.de, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, francesco@dolcini.it, imx@lists.linux.dev,
	jun.li@nxp.com, kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, xiaoning.wang@nxp.com
Subject: Re: [PATCH v7 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <ZwBdOSobshR6mOi3@lizhi-Precision-Tower-5810>
References: <20241004193531.673488-1-Frank.Li@nxp.com>
 <5cvzarqkldstuziokdbxxne75i35odexkcykzikyq2gm6ytdyd@5wkm7mhotgej>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cvzarqkldstuziokdbxxne75i35odexkcykzikyq2gm6ytdyd@5wkm7mhotgej>
X-ClientProxiedBy: BYAPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:a03:117::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 76961233-f2ad-4bc0-fe77-08dce4bb0e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2lDZytwVitxbGNqNHY4YVZLbi83d05rUUVaOG9IOEkraythUmtHM05ub0hi?=
 =?utf-8?B?WjIzWWtYTHVXWEY1dnE1V0V6SzJ5T085YmhmM2lJM3BWbERiUld5M2dYN1ZR?=
 =?utf-8?B?L3NkSzBIRDcxb0hlSCtiRGhqTUN6U1ZqZC9pZHBYUnMyOE44c21BbGw5UjlE?=
 =?utf-8?B?YU9Od0M4TnltNWpjNmN5VDB0bkFoQks0UllUNDBJUGNVNGk2ZW16MEdCeTJM?=
 =?utf-8?B?eGRjVGxycEFtdDduZHBZSHpyMkRwM3NnR21VSzRVb0NUdDZHWGNtNFR0MDBG?=
 =?utf-8?B?MlZydXpXZDRiM2gzQXo2c2owOGQ0V1JCNllMY1JNMHp6U21EOC9kYStvSFdz?=
 =?utf-8?B?Q3BjemNZVHh0REpLYVpqaHg1bnZEKzhqb3JMc0p3eU55VnBGRXkxV0g4cnhm?=
 =?utf-8?B?YU5aQ0lMMmo0a1MwQjVXaFNBN2ZPTkxWRkw2M3FoRmlielVVbDFHenNSSlpE?=
 =?utf-8?B?UEFWOTVpVHFnYnl5bFFQenhPbDJZeThXb2tZaEVidlFaYWxxTFZaRXE1WmEy?=
 =?utf-8?B?WVhmbTBhL2Q5NWVUanlNdXdoc2EvRG9xdEw5ZmwwbjhWbk5raWx0MWZpdGRv?=
 =?utf-8?B?SHVjK1NCN1NvWm55cVZlTkdEZlJpVFNJSnBwb0oxVEhiSTU2ZnJFUlU4MUJy?=
 =?utf-8?B?RjBXVWlhbzY1bVRuMDRhWVdIYXZDZ0VhOGZUcVpZSlZ1b0xFVkFTbVJURkx4?=
 =?utf-8?B?QmQ3b0QxN2ZQZENiclZzcEFDbjFtNzI3T1JpV0lPTzYzMEt5dHFidmNLZ2o1?=
 =?utf-8?B?LzRXUFpPdTNJMGg1Tk45TVRHQXppbFlhWHRoZmhucnlXWGxTNGFQVi9GazdW?=
 =?utf-8?B?RHFlVzZqcVlrZitDVjBURWhEM0ZqNTFZaFQvN3F5cWt5V1J5L1hpRnVvbmdE?=
 =?utf-8?B?ZlF5cGpBdWZJTzkvRjdia2pUdDM3NGNRdS9NZmZHR0hHUjh4RXRGYUFJYkFB?=
 =?utf-8?B?MjJGNHdJUzI2WTRCYjFDMHB5aWdTa1pHQzU2Q3VSczFVeEJYeUhrZWJ2QUtX?=
 =?utf-8?B?WnlSVFVmd3EvbU5iMmNpd0dCcUNYNlh2L3AycnJaWWNocFFGZkZraEJ3bUJH?=
 =?utf-8?B?WjJnTGZZWXhLdEtOMHZnU1dwcmRVRkp2UWQ2bG5KWUJwK3U3RXVodkRYTHlO?=
 =?utf-8?B?clhablJyT2owQkJ3WFdsc0tSVG1PVG1sTUwvM3pRMUZNY3Y0SllYa245Vzg2?=
 =?utf-8?B?NVVuck01UW9yWXBOUS9ncU5YR2oyRC9hV3Z5Y1Nna3ovWGpVVngrMFNGUkp1?=
 =?utf-8?B?Qkl1Y3ZYckxaempMYVhUbm8rTmNlS1gyaUwxMzdlY2xpT3pNYkJxcktGR2NW?=
 =?utf-8?B?QVQ0WXN1bTlmQmNleUh1YjhmbXYwNEw2Rm14eVdHRXpKcXdva2dYdFVPV2E4?=
 =?utf-8?B?UStpVUxzamk3UzBhYWw0Rlp4Y2paVzM1VlU5WGRKd1VkQklaZDQ3eThEb3U0?=
 =?utf-8?B?TjBoY1JvZEViQVlsWHNJZ2lBVlgrUDRjS0llaGM5Q1JOTHcwSTFCdVNBUHhI?=
 =?utf-8?B?OWdBVWdwVkw1S1RkTXZ0Vm5PSklxVlRuVG12WEEvWmRoT1p2OVNJZFN0SnQx?=
 =?utf-8?B?TFp1bkRPRTJBY1l2ZjlLeFptNThFOTY2eXk4RXNkMENxOTZoSHJoWEZQWFpw?=
 =?utf-8?B?cTh2S0U0eklNYXdEUHkwakVzRXpBL0hUWnVZUjlzLzVkc1VuVVE0R0xaR0NT?=
 =?utf-8?B?aUNXeExqaHVPT0tSYjBVTXJSTXdvS0dKKzdjbjdvRnA1ZDRYVzQvNk9NVzRn?=
 =?utf-8?B?L3FLakFpUkpVSXgrbGtuV3E0OWs1UHVZN3BVbmltd1ZJWGxjZEJidHp0U1lx?=
 =?utf-8?B?UXB5dVkzSktuUXk1THhCZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2JTdUE0dW1NSzNXa0xrQ0prS3JOTVNvVXR6ZHJVeEs1czljQ3lhcmVwZzF5?=
 =?utf-8?B?RlVmSkhDUXBwQXZuT0tIZ05qd0FTckZKMmF6NEl0dVlhb2haZlhCQ2pHSkUv?=
 =?utf-8?B?eXY4UzJtQnJBenNMYzEreFEra3NibjVvVnNYRlZVallnbktSYUwyWUZ3ZVQ0?=
 =?utf-8?B?V3RYS0tzNzIzQmVDY2I0dThmVEpEWElMM1A1b2JPRzB3QTBzZjR3bkdSVjJ4?=
 =?utf-8?B?TWtKUmNsR242Vy83WDAzM0VWVnFZcFVYbmlkcXdlY0JuV2hudWxHRXRUUVlv?=
 =?utf-8?B?RmpDblNGRXlESllqK0hQazBPN1VzYTJPSDJ4Qk9qbGR0QkQyN2kzK3ZVb3FZ?=
 =?utf-8?B?aUZpTWYyRTU4bENCM3ZLNHdqa2QvdjJQd1hENWRCVzBHenMzK2szNEVWOFBN?=
 =?utf-8?B?amdiUjRVMFJvRFoxUkozYVVYTytLYm9ycnBhY0U2WHF2YUhickd3b2JZTlNn?=
 =?utf-8?B?VFlTZkQ5MmtIYkg1SGplUzZYd3owN0FsOEtNU0RlR1d3cGIyMk1FeTJXa3lV?=
 =?utf-8?B?WE90dWFNbjd4Y1kxOW0zWndqbWRuYVdKVGlsWjExUEVyaWJyeTBFeE56UFJG?=
 =?utf-8?B?RWhPVGgrQi9YYXJ1Y3ppMGU0TjhXYUxyR29WOUlwQk9rOFJlY3RXVEZKcVBj?=
 =?utf-8?B?Q2xwSzhrWmhYQjlYQ09ML05mcVFxQlE3VE5EeGdOT29wZEpUL3c3ZXZxODJw?=
 =?utf-8?B?Q1F5cVFOY0NPK1JkMWdrYzNxVXgwdXF5Q1FTaUIvWlNrWnhHa3IzY1VwUEN6?=
 =?utf-8?B?dm1hQ3gzSXVHYU90aHFMV3NQa1o5SlRJMHhZem5sblNaamxiRnpBM2t2dndy?=
 =?utf-8?B?NWVxM1lTSkpQTFFpMXFKM1F1MG1rRjVHSndPSDlQNXB1UDc0YWloMlJvTTNr?=
 =?utf-8?B?bmI3T240aVJVL2dvZlFEeFkzVE45UHFOZG9ranZ0L2JCVmtiSzhLZXhoSFh5?=
 =?utf-8?B?Y3VaMUZQU1RpbW9UYjBjdkxqdGg4MUJuS1FBRUZKbDNZdWdWS2oweldQODBG?=
 =?utf-8?B?WFd0ZkQxenA4TURJa09GaFoyRHBDaHJHWmNTQXVtbldSQkUrWGZWVmhWblo1?=
 =?utf-8?B?MkR3clZISWVka3ZXNWl0eEUyci9YMGN3UXM3bHk4aEZFVzYyK041aEVFSTd1?=
 =?utf-8?B?TkxJNmk4bCtuZGdyRjh3SUIvK3FGQkxxSGdDQmhVc1ZpZ0VXbkExNXl0WmJU?=
 =?utf-8?B?N01QZXlYSGl3aTUyRmhmUHZkZ2hBbkVKT1JiMmtwbGdXcjRnQUdpbFc2TE5L?=
 =?utf-8?B?TUovSHg2Z2lRNlQvc1RSbEVXREY4NWVHT3MrS1JCbllUOHhWQXkzOFMwSVll?=
 =?utf-8?B?N3dFb1FiNkxBckwxZXl5eFZ2UThjWVJLYk0zZ09GUGdpQUExc1ZyU1Y5UkpE?=
 =?utf-8?B?ZzZvWStmSDJURTRDZlRnRDVNeTZQRFo3SkdHUkp1SGZXd2ZOMWxaVjZpT0dI?=
 =?utf-8?B?TU8xVittWGlhQm1JR0dIQkNjUk9kY3FINHdYbHdGSkM0MUU3T2lldytTdEdG?=
 =?utf-8?B?aVpDeXA2Y0JDUFdGaHM2QmhWSS9MSmphQXFrK1FLUGVUMEc5TjlHczBKL0NT?=
 =?utf-8?B?RGc3TXpsN0o0ZWpQcENlbzhLTEpBZ2J5OWFYOWZvUmNvRlNGTWIrMytwTDYz?=
 =?utf-8?B?TGc1aEs5TXJaVmtvL2pRblhWdzBDTXp3ZnNzL0hzc1VDNnhkSzJtbG5yeHht?=
 =?utf-8?B?cVgwNkhPM0w3YXVMaEJqc3UwbllyQ0h4THdsTXdkdEJMelBVamR0cVIyR3U5?=
 =?utf-8?B?VUJldkIyaDZzV3FVblIrVmw0NXFVUzIzK1RjVTQ3Z1V3SEZ1UGYzYUQ2bXFK?=
 =?utf-8?B?WktSMWJFWEY5bkRkZ1FGa1Fsa0IzZndMR2gvQjNjL3JQQkVwcWRicmlmK2Np?=
 =?utf-8?B?S0ZibUVJeEw1Y3EzZFRERlpYWFNDaEZUUWVsRzJqWHBoV3pmTmUvSUQ0cEVJ?=
 =?utf-8?B?QjMzcWtYV3dtL1dTdHRXVUZwVFgvZUwyVnFJRXJIY2x3OXU3K1hJM3g0NVBO?=
 =?utf-8?B?QVcxR3Fpdk9IUHEyRzlOYUtVd3g1YUp1Tk1oTkhkNmpaRlFwZEJ5M0xEZ2Jx?=
 =?utf-8?B?VGVEaUNnVkJQelZ4WFlLV1NnbFpnVzdBSlhCVEhHY0NHVm1jaFB2MFovMlNQ?=
 =?utf-8?Q?B78cc8XRBI0iBDH8iksd1cvGh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76961233-f2ad-4bc0-fe77-08dce4bb0e5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 21:25:23.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQHppaDIl9qEqwjrKnP4xqjyF6I8W/hRHxNL24iymUizIF28oVfJDfNgSuAUNNOLqf8ZVsp4lrFri2LXzS5PBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10763

On Fri, Oct 04, 2024 at 10:58:49PM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 04, 2024 at 03:35:31PM -0400, Frank Li wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> >
> > Implement workaround for ERR051198
> > (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
> >
> > PWM output may not function correctly if the FIFO is empty when a new SAR
> > value is programmed
> >
> > Description:
> >   When the PWM FIFO is empty, a new value programmed to the PWM Sample
> >   register (PWM_PWMSAR) will be directly applied even if the current timer
> >   period has not expired. If the new SAMPLE value programmed in the
> >   PWM_PWMSAR register is less than the previous value, and the PWM counter
> >   register (PWM_PWMCNR) that contains the current COUNT value is greater
> >   than the new programmed SAMPLE value, the current period will not flip
> >   the level. This may result in an output pulse with a duty cycle of 100%.
> >
> > Workaround:
> >   Program the current SAMPLE value in the PWM_PWMSAR register before
> >   updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
> >   register. This will ensure that the new SAMPLE value is modified during
> >   a non-empty FIFO, and can be successfully updated after the period
> >   expires.
> >
> > Write the old SAR value before updating the new duty cycle to SAR. This
> > avoids writing the new value into an empty FIFO.
> >
> > This only resolves the issue when the PWM period is longer than 2us
> > (or <500kHz) because write register is not quick enough when PWM period is
> > very short.
> >
> > Reproduce steps:
> >   cd /sys/class/pwm/pwmchip1/pwm0
> >   echo 2000000000 > period     # It is easy to observe by using long period
> >   echo 1000000000 > duty_cycle
> >   echo 1 > enable
> >   echo  800000000 > duty_cycle # One full high plus will be seen by scope
>
> That should be "pulse" I guess ------------------^^^^

Yes,

>
> I would have expected a much lower value for the second write to
> duty_cycle. I guess it depends on the machine you run this on if this
> hits the race window.

Yes, lower value can increase reproduce rate. I can change to 8000 at
next version.

>
> > Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
> > Reviewed-by: Jun Li <jun.li@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v6 to v7
> > - Add continue write for < 500hz case to try best to workaround this
> > problem.
> >
> > Change from v5 to v6
> > - KHz to KHz
> > - sar to SAR
> > - move comments above if
> >
> > Change from v4 to v5
> > - fix typo PMW & If
> > - using imx->mmio_base + MX3_PWMSAR
> >
> > Change from v3 to v4
> > - none, wrong bump version number
> > Change from v2 to v3
> > - simple workaround implement.
> > - add reproduce steps.
> >
> > Change from v1 to v2
> > - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
> >   About disable/enable pwm instead of disable/enable irq:
> >   Some pmw periphal may sensitive to period. Disable/enable pwm will
> > increase period, althouhg it is okay for most case, such as LED backlight
> > or FAN speed. But some device such servo may require strict period.
> >
> > - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
> >   Using official errata number
> >   fix typo 'filp'
> >   add {} for else
> >
> > I supposed fixed all previous issues, let me know if I missed one.
> > ---
> >  drivers/pwm/pwm-imx27.c | 75 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 74 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 9e2bbf5b4a8ce..00a7189ba46ca 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -26,6 +26,7 @@
> >  #define MX3_PWMSR			0x04    /* PWM Status Register */
> >  #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
> >  #define MX3_PWMPR			0x10    /* PWM Period Register */
> > +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
> >
> >  #define MX3_PWMCR_FWM			GENMASK(27, 26)
> >  #define MX3_PWMCR_STOPEN		BIT(25)
> > @@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> >  	unsigned long long c;
> >  	unsigned long long clkrate;
> > +	unsigned long flags;
> > +	int val;
> >  	int ret;
> >  	u32 cr;
> >
> > @@ -263,7 +266,77 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		pwm_imx27_sw_reset(chip);
> >  	}
> >
> > -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	/*
> > +	 * This is a limited workaround. When the SAR FIFO is empty, the new
> > +	 * write value will be directly applied to SAR even the current period
> > +	 * is not over.
> > +	 *
> > +	 *           ─────────────────────┐
> > +	 * PWM OUTPUT                     │
> > +	 *                                └─────────────────────────
> > +	 *
> > +	 *           ┌──────────────────────────────────────────────┐
> > +	 * Counter   │       XXXXXXXXXXXXXX                         │
> > +	 *           └──────────────────────────────────────────────┘
> > +	 *                   ▲            ▲
> > +	 *                   │            │
> > +	 *                 New SAR      Old SAR
> > +	 *
> > +	 *           XXXX  Errata happen window
>
> Hmm, ok, so SAR is the register value that implements the duty cycle
> setting. And if a new SAR is written, it is directly applied to the
> hardware and this way it can happen (if SAR_new < counter < SAR_old)
> that no falling edge happens in the current period. Right?

Yes

>
> If so, I think the depicted PWM output is misleading. I'd describe and
> picture it as follows:
>
> 	/*
> 	 * At each clock tick the hardware compares the SAR value with
> 	 * the current counter. If they are equal the output is changed
> 	 * to the inactive level. As a new SAR value is applied
> 	 * immediately to the currently running period, it can happen
> 	 * that no falling edge happens in a period and so the output is
> 	 * active for a whole period. Consider a change from
>        *     ________
> 	 *    /        \______/
>        *    ^      *        ^
> 	 * to
>        *     ____
> 	 *    /    \__________/
>        *    ^               ^
> 	 *
> 	 * where SAR is written at the time marked by *. The counter
> 	 * didn't reach the old (bigger) value because it was changed
> 	 * before the counter reached that value and when the new value
> 	 * becomes active it is already lower than the current counter
> 	 * and so doesn't trigger either while the counter continues to
> 	 * grow. So the resulting waveform looks as follows:
> 	 *
>        *     ________        ____________________
> 	 *    /        \______/                    \__________/
>        *    ^               ^      *        ^               ^
> 	 *    |<-- old SAR -->|               |<-- new SAR -->|
> 	 *
> 	 * that is the output is active for a whole period.
> 	 */

Good.

>
> > +	 *
> > +	 * If the new SAR value is less than the old one, and the counter is
> > +	 * greater than the new SAR value (see above diagram XXXX), the current
> > +	 * period will not flip the level. This will result in a pulse with a
> > +	 * duty cycle of 100%.
> > +	 *
> > +	 * Check new SAR less than old SAR and current counter is in errata
> > +	 * windows, write extra old SAR into FIFO and new SAR will effect at
> > +	 * next period.
> > +	 *
> > +	 * Sometime period is quite long, such as over 1 second. If add old SAR
> > +	 * into FIFO unconditional, new SAR have to wait for next period. It
> > +	 * may be too long.
> > +	 *
> > +	 * Turn off the interrupt to ensure that not IRQ and schedule happen
> > +	 * during above operations. If any irq and schedule happen, counter
> > +	 * in PWM will be out of data and take wrong action.
> > +	 *
> > +	 * Add a safety margin 1.5us because it needs some time to complete
> > +	 * IO write.
> > +	 *
> > +	 * Use __raw_writel() to minimize the interval between two writes to
> > +	 * the SAR register to increase the fastest PWM frequency supported.
> > +	 *
> > +	 * When the PWM period is longer than 2us(or <500kHz), this workaround
> > +	 * can solve this problem. No software workaround is available if PWM
> > +	 * period is shorter than IO write.
> > +	 */
> > +	c = clkrate * 1500;
> > +	do_div(c, NSEC_PER_SEC);
> > +
> > +	local_irq_save(flags);
> > +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > +
> > +	if (duty_cycles < imx->duty_cycle) {
> > +		if (state->period < 2000) { /* 2000ns = 500 kHz */
> > +			/* Best effort attempt to fix up >500 kHz case */
> > +			udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
>
> I don't understand the motivation to wait here. Wouldn't it be better to
> write the old value 3 - val times and not sleep? Or busy loop until
> MX3_PWMSR_FIFOAV becomes 0?

It is required by Marek Vasut. Read register is also quite slow. It is
hard to hit this branch and can not 100% workaround this problem when
period is short. Just choose simplest mathod here.

>
> > +			writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +			writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>
> With the comment above I would have expected __raw_writel here?!

I forget update comment. writel_relaxed() is wrap of __raw_writel().

>
> > +		} else if (val < MX3_PWMSR_FIFOAV_2WORDS) {
> > +			val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
> > +			/*
> > +			 * If counter is close to period, controller may roll over when
> > +			 * next IO write.
> > +			 */
> > +			if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> > +			    val + c >= period_cycles)
> > +				writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> > +		}
> > +	}
> > +	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	local_irq_restore(flags);
> > +
> >  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>
> I didn't find the time yet to look into your other pwm-imx27 series.
> Does it conflict with this patch? Which should be applied first?

No conflict, but let's work out this patch first. I think 32k patch may not
necessary because driver have not use 32k clock source. It should work
without 32k clk.

Frank

>
> Best regards
> Uwe



