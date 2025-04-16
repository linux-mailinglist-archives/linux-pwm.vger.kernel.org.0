Return-Path: <linux-pwm+bounces-5528-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02CA8B49A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352E93A9DE4
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575EE22E418;
	Wed, 16 Apr 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WqTDs9C5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D328A32;
	Wed, 16 Apr 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794049; cv=fail; b=PqUMxUuptC6zhxvdh2bxv48TJq7HFJXnHElDcTmi8jKcpomN9LEtmdWQ6v3KU6o7nYUBfc4kyOb1vZFkXwcBjJ1DXbQJbcZLXShBRsEqvAZsPV8dAwWc/lB7jCASOWZVD5ICVAgjXdwTSNUVrzNTn8Iws6ha9KSJ8G5sm9+uDuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794049; c=relaxed/simple;
	bh=kLG8EzQd1dd+XXiWZkMYIQXi/d4Se6eOY4BsJDHBzw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SUBRTdqKe52nOtAaEPo19Ur4i73yzTlpTLmGIHcz0r3QB0G7iinI06/rNuNKNjLx4cfBfM6d+QpG1KARmO32KV8PSMc8tMUUf6s71zcTk4BBkT3kxdFUCXiiz16EjSze5/DS4Dd/CAP/GlEOsRZS4SUchP7gIurBRrF+uHfrNZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WqTDs9C5; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsM5APsxNAH/xZNjW3GA0jspWwxv6fQIFqnvLoP46i08MvXuHl83EBiC2Dea9R9IaQpP7njcpwsWs67hNcHOiRwIVJDYtwWioQwWNu6CppPHjCrjPEQcgS+jWYuII/0lE7FOlJgleJ9FIMplAbiliJCkkleO3TW5BbwYDvKkJt97s4equOI9XZwA9TEBfSENywDPZlCnOVl7dNbKMRk5CL7RudbaUEZZq40/bqEh7HH+b08Thng6GwdmonWAd3FGl29vMAgB48f8k0lH5EPKNjboQi3jNWxJt2RXPdfkxnrE4c65DHJFEH8CJx2dBxZzFEiXBaWcmEXHThMi4CnqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a6QpAzyB5tQzlTMNPKRKhNoMbkv4nuJtECk3dIP7RM=;
 b=NEk4OYoCxDABvNFpNnkkgtXhaC5pAvZSSOFBT4uJCelo17dKfNag+3GAL/kXi+sSSas++vHKsWWe3dL6HCF5hBeQiUKgyM4jKYniY72aa1M3EC/G+afjOiccT9QD6p8sDF6ngaLHJZrVvQ+ZRsibdsjJzEewK2DYgQvjcBCbaOhkIOlSxppjVKGrm9PO4hHL4gxE4Qvyzmbj0Ccm6IOFpdTwgX0zWRNubZE5SI1ec6DsTTEt+ndiiIaTFhBUG1GqKTfRKvkzdx0vxMvVjPyKiJvbC6bG5tV6xsDbVUr/rLxrZZ2TQqoQW3zSgOBQQyu2u7NRk8On4wuUaL5JIioshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a6QpAzyB5tQzlTMNPKRKhNoMbkv4nuJtECk3dIP7RM=;
 b=WqTDs9C52V8/XjCpqKgUzTNGHSnApRCEqX0RarDf4QeWSZygQnN5R1oopUbJlBzuVFQbJ02iGSwrNrlWcWhNX4L5b1JhzZtSzwZoP+mPHspuM7rfOgZcwMiMSMyAMJ4lCMyGSxymp4XmvTvZAjlbnH/VJF7gZgEniETV9ecCG2NW9gF2Gi3QE2vfA/P6hzlTh5RMDL+DCdfydbQn4hdAg5FDT/tPBq7s2/x2Xss51pl5U517lg1EZOoiRKzl0f4fKPs5nIj6cvTFJbvXtj6LRJwitj27weDsKxpfRQJgykBiVjDlHMzrl3PHrZSDsWpnvTXkJBlm86F2sBTLkk/+cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB9220.eurprd04.prod.outlook.com (2603:10a6:102:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 09:00:43 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 09:00:43 +0000
Message-ID: <3efb68e2-7091-47e1-81a2-39930da5a427@nxp.com>
Date: Wed, 16 Apr 2025 17:02:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
To: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b0b147-64e7-4c7b-33a1-08dd7cc52b19
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NFBJMUUyZ0FUN3ZXSHI2VUhlZ0d2RzBMUzYvbDQzYlpZQVFETWJELzR3Yk5s?=
 =?utf-8?B?b0VEYWt6TWoyWHlCbUhGcGZES3oxSlNPTUQrUzc2bHVZaERLNjFHNHBQR2xj?=
 =?utf-8?B?ZEJXWUNIRTVHSC9IQ1JrSHpaVlhjdFc5NXV0U0RLZzFqcTJ3ZWExQndwL2pS?=
 =?utf-8?B?ek1qSS9LU1k5TkZPSXJrRzI4N2VBUngrNmJGWXdVMHJxcHdkaTcyM3hYNEN5?=
 =?utf-8?B?dEZMU3NIcWV5N09BSFhkK2FqaWJJWm5vUm9WT1JWblZUcnRsczZBQ3J1UUJh?=
 =?utf-8?B?dER0QmtLd3l1UnNPRXRoeDM3V2dJY2RTZHNtQjVSa25DU3pMNS9SOFdJM1BM?=
 =?utf-8?B?RUYzRnc5UXUvS1lXaGRrdThHNGV3N0MzbmI4YlYxcThYVWlMeFZiNUdnODVO?=
 =?utf-8?B?WHcyK1BQeVJ6VndpNlpCVWZhZU5CNG9KcWpDNUxMVXBsbTRSenRSdlRzcTFS?=
 =?utf-8?B?ZGlWSFlnTkdnWFBkR2k3MUZEUTNiS1I0dUFPQVMwQXNNNmM5dFVvQnlUV1RZ?=
 =?utf-8?B?eDQ2RWhWSngveElQTzFkS2h5MnY3SjN2cysxZTFyR3ZLOXpncldOcXFySmFN?=
 =?utf-8?B?Um9wamRwZUVlQXhlR29TVUZ6akZ1WUxQS2cxWWdVdkNBTE04WGxwcTRaVG1T?=
 =?utf-8?B?RXlCMDJuWVRYc1ZqellRbWdZSFhJNTVuTDFDSVdCRmRIRVdVbFJpZk15eUMv?=
 =?utf-8?B?dE1jUzJrSW9CYUpTNFAvVndadVRhM0lpMUJuWENxZjlFek0yZSsvSnNnUDJO?=
 =?utf-8?B?WGRZUEdQd1BIQWFHc3RZL0x1bDFLc3RFZng2WjA5bWgxMlhRUXc5dmwxWlNW?=
 =?utf-8?B?eDRyNGMvMWtPNGRQZlRYSzA2RlFHWjM5VTdMS05oRC9OYXMvS2h1R055SVVa?=
 =?utf-8?B?VUFtbHpnQUw3MFZ1NTJmMEpIbTNENnJacHhmUldZV1p2bEVqWjlZOXdvK3J1?=
 =?utf-8?B?N2MyMGdqeEkraG5nREZJM2Vpb2FxUk5GTURJQnhTL2Q0cEJxaEFmdG8wOHk5?=
 =?utf-8?B?T05zMFJUMG94RE14WGhydEc0cTVITG9Nd0JpN05IU25GdkFSYUlkcW5WSUFi?=
 =?utf-8?B?S0xBMUQxbFdwZzZpcHhQMmp3bjlWY0xuTllwV3REcGx2NTF6S1ZaQ0owNkdj?=
 =?utf-8?B?ZUZqbnRzeFJ5dmswSzNrUXl3aVlZb0NMcU4zelZaSDhpUFliUDl6RXhmWmhk?=
 =?utf-8?B?eVE2bkE2Y2VtNWJ0NHMraTMrUy93cXhkVzFYcWxUZVBOQjA2dnpxMHE4T0lC?=
 =?utf-8?B?bDVuMlp6VElZaTM0Qlh2aVVDdU0zT1pBL3VjNEp4YUV2STJ4a3lUSVNsRDE0?=
 =?utf-8?B?eWs3bEVqakJKRG0yZ0toVTFkZHdsdDZ1NVZzT292Z0cyS205cGRJZDh1Z1dk?=
 =?utf-8?B?V3BKc1dseXJMTVBrUzVOYjFJaldRNEJtb2kva21GSUs1SUlaQUlhVFBuRGN0?=
 =?utf-8?B?NW9TdGg2Tmw0Z2hSVEdCKzd6eE5LNFE0N0J0V0hvRHpsS0hxdEFKOVBHYzNU?=
 =?utf-8?B?M0FkbFpTSE5hbThCUXhFdGNKYUVYVHlENEt4VDhuUFBtWUJtMktGMnJKWUUw?=
 =?utf-8?B?WnhodytJRCtTbU0zS0ZXdjdlOWNDc0FWeVg5b0R6UTZFMmFvN2JOMGxrOWJQ?=
 =?utf-8?B?NDBzR2szMU1PT3lSbnFnT1AxcjJtcmRqYlVybGtYNDJZS081M0FwZ2RGakJX?=
 =?utf-8?B?elU3YkhWQmRYWWozamNPdzVmRTNVb2NhTkNPNVlVTTlVU2JOdXdjSTdxdE5n?=
 =?utf-8?B?VS8wOW82THVRZmFuTnV3WlM0S0FNTTkwR3NJRUhNTTlyMm9oTkZLL1p0NzBO?=
 =?utf-8?B?b0E2RGRoTEVIN1VzYkVoeHI1QjVhMkd3NGRIQVJpWnNrTlJmelVNYWRkYy80?=
 =?utf-8?Q?ChgZ51gvIX9gz?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MkFDV3lmQ1h5Yko4QUNCcUxJZ2plQmRNN2o2a2tmRit2RWxQR0RXVnNlTE91?=
 =?utf-8?B?NnNNeGtVWTJEUjY2VHFndXBaNU5UVzk1VTR0TTFRRUZwV1RmRU15eWVmUThO?=
 =?utf-8?B?U0I5Z1R6c0Z4d1lJTXhES0RWMHVKSmJlVWNtMllOclBVUkVMR0hLUjV1bGs4?=
 =?utf-8?B?LzlzSlBsaEJIVE1LY1R4emIrVWJBcU1oNUd2YWVkZWV3OGtrREdRZVhlNTRh?=
 =?utf-8?B?RVR2cmdDZ3hxaE1FR01CMmhGTkpZbTNwU25UT2JBdTduWXFJNTNXZ2FrQXBU?=
 =?utf-8?B?WG5Xd29FNWZNLzh3Vm1LU1lpUWdxc0ZTWTdxUTRZQ0FteTBEYVdjeTlhUm9v?=
 =?utf-8?B?UFNZSlpiakRuWC9ER25Dekgrblg2KzM5WFFzTC91ei9PRzMydHl3OUpiRlFY?=
 =?utf-8?B?Y1JmVWNNMjc1VDQ0MlJFUjlPT1UwMFpCN1pVZHlFMGhVUUJoelgyWmZmUVdP?=
 =?utf-8?B?bDJSb2xHdjMrVkcwcDlLVDFxb1BvYTRsbXJxMjBqd0NHY2dlQWl3V2k0YTUv?=
 =?utf-8?B?WVpTTlNLMzRGck0yQ2dCMU40MmVzUFpDMkdhaTFVa1Fmbms3NGlDc05mcERu?=
 =?utf-8?B?UExKckx3Z1dkSzZGa3IrblFLdFgwVTZ1T1ZBMlNRZmpWaWxNWWQ1bmN5TE9o?=
 =?utf-8?B?U3AvajMvRFVxeG01WEdRNkl5UlQ3YVFGODdlVzlPS2VtMnlUWnlMSEZTK212?=
 =?utf-8?B?dW54TFJVdWc3dFNweFZhSm5CTWFzUG40NnRpVjBpYkRGdktSRElFOFdpUjMx?=
 =?utf-8?B?bjZPK3BDZjNKcmVNY3FaN0xHdWFFOXQrd05xb2V0Nkl4cWJYd0d0dzArTUZn?=
 =?utf-8?B?eGtRN0dHS3hIT2FBRldNTnI0OGQra1JkSk1nT3piWmVzb2dMd1dBRi9iNXdp?=
 =?utf-8?B?OUlJa28vMTNqTXY5VGZiUFkrNUN1M25LREZIcW1QWmV5dlUrYXVMQWVkcExn?=
 =?utf-8?B?Zll1c1h2TDVGMGVPdHV3Y0V2NFZ0SlZGL1RHTHl6dzZ1a3JENFlqTVVlb0l0?=
 =?utf-8?B?eHdTbEZwczZsNmpWSTZrV09vRkdkWlZBSGVaMWh3NExBekNoN2RzcmQrNW5Z?=
 =?utf-8?B?T2t4RFA5S0lvUzhpdXFGT3hiRUtpYzFGdWhWZ0dxVkJuQzliblcvVFl6c0N0?=
 =?utf-8?B?eEJ3ajJEOVJwVW9CZk5qSy9Ta20rdnNtS3o3ZWZ5dmtncWpPUVpEQitRekZO?=
 =?utf-8?B?bUttT3BEUXRhNzNraFVxZzR2cTVmTzJONXZrOHVKeW5JbVRySDNMNjhBQUJO?=
 =?utf-8?B?NEg1YnF2V1ZtM2UvZGMvM3U3UG03MUpqM0RzOUxzTFc2RDZpdkk1Nzl2eVR4?=
 =?utf-8?B?VTl1YkxVM3E0MDZsSVZVMGNqYUgyQkMxYkRrVGdxOXBtNndqWWVuTWwwZy9h?=
 =?utf-8?B?Y0lCNXZxRTNGeHdWL0J3WTZmM0RzeHo1NzkxaXFUWEZ6YmJkSHlQQ0ZNMFpD?=
 =?utf-8?B?NlFOMkk0OWNUMVpaZzh2cGtnenVoRkVGblZvQTNCajBVeDdSUjVhK2tQMnMw?=
 =?utf-8?B?Ky80bkNPV2RpT1U1eitKc2F1YitrQnNmL3BUSktQTVRURkN5bUVjYTF3dkFI?=
 =?utf-8?B?aEtyRElOUmsyelpEYzZ5eWQvcXpWam5VVnB3MkxwQlFvemgrUzIvcHBqK2ZY?=
 =?utf-8?B?WUpFWFhuV2hRd0xJblFWbTNMWDFBVWdNeHlGUytqUFpQYVRicDVlQmF0L0N5?=
 =?utf-8?B?Tkx3SkNrR2JCT1o5WEM5aTd3UkdPaTlORWZKam50S2g0M1RLUWQvYjlGMzZN?=
 =?utf-8?B?MXovRHNzTllwcm90U3RwK0VENnR5MU1CSStiRHRQOTNOeW5VQlovcGVkVHFB?=
 =?utf-8?B?V280WVo1RVN2TGZqajlQK2ZEVjM3aTE3VXZKTXVDYW1ySCsyMm9WaHB3S2wy?=
 =?utf-8?B?UDdpZFZsZVJPZlZMMnU3N1RPNTVFZUJ5czZUUkl4MlVkbGk1QVB0M0twUG1H?=
 =?utf-8?B?K3NVVXRzZUZVaVJFbWdudlp2d2F3Y1FDSGkyWk9zYjhieE5jYTVUUEN0cWp4?=
 =?utf-8?B?OE9vL3ArenF3RE0yUk1wVDBVWkdTNE1wdktqRzNsSWt4ZVFmVlVOVVY2b0Nr?=
 =?utf-8?B?emJYT0ZXZDlmTmZwTk80bndKQStSa0VVVDdscVNnWVVOcm1JZ29BcFg5aHNJ?=
 =?utf-8?Q?GgDNSW1yb1YzreZMRz6WdGero?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b0b147-64e7-4c7b-33a1-08dd7cc52b19
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 09:00:43.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+sndbDnsG+Hh+DSvgEm/8Da1lgC/NzcIhww+d4c3IrPj0/hB/NU4kg3IY8Vey1uRylr799rqMtbcjzOLUhSAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9220

On 04/15/2025, Nuno Sá via B4 Relay wrote:
> The adp5585 MFD driver was introduced in 6.11 adding support for gpio
> and PWM. However, the gpio part of it was already supported as part of
> the keyboard driver:
> 
> https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/keyboard/adp5589-keys.c#L532
> 
> On top of that it also overlapped with my refactoring of the above driver [1]
> to drop usage of platform data and use FW properties instead.
> 
> Now, it actually makes sense for this device to be supported under MFD
> and since the "legacy" input device depends on platform data that is not
> defined anywhere the plan in this series is to add support for the
> keyboard and adp5589 devices as part of the MFD driver. Once the MFD
> driver supports all that's supported in the Input one, we drop it...
> 
> For DT Maintainers:
> 
> The compatible for adp5589 is part of trivial devices. To me, it makes
> sense to remove it in the patch where we drop the driver but doing so
> would result in a warning when adding the same compatible for the MFD
> bindings. Hence, I remove it in that patch. Is that ok?
> 
> Uwe:
> 
> In my eval board, I could see that reading the GPIO value (when
> configured as input) does not work when OSC_EN is not set. Therefore,
> commit ("pwm: adp5585: don't control OSC_EN in the pwm driver") could
> very well have a Fixes tag. However I'm not 100% sure it's a real issue
> or something special to my eval board.
> 
> It would be nice if Laurent or Liu could test the PWM bits or even
> check that the above is also an issue for their platform.

With this v2 patch series, PWM backlight(controlled by ADP5585 pin R3) still
works for my i.MX93 11x11 EVK.  Without this v2 patch series, if I change PWM
backlight to GPIO backlight(keep using pin R3), the GPIO backlight brightness
can be set to 0 or 1, meaning I can see the backlight is off or on.  So, it
appears that GPIO output still works when OSC_EN is zero(I dumped GENERAL_CFG
register @0x3b as 0x00), though I didn't test GPIO input.

> 
> [1]: https://lore.kernel.org/linux-input/d1395bd61ce58b3734121bca4e09605a3e997af3.camel@gmail.com/
> 
> BTW the series is based on linux-next/master
> 
> ---
> Changes in v2:
> - Patch 5:
>    * Do not nest if:then:else::if:then.
> - Patch 6:
>    * Make use of the adp5585 info variables and adp5589 volatile regs.
> - Patch 9:
>    * Use standard "poll-interval" property (and move it before vendor
>      properties).
> - Patch 10:
>    * Make sure to include bitfield.h.
> 
> - Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com
> 
> ---
> Nuno Sá (17):
>       dt-bindings: mfd: adp5585: ease on the required properties
>       mfd: adp5585: enable oscilator during probe
>       pwm: adp5585: don't control OSC_EN in the pwm driver
>       mfd: adp5585: make use of MFD_CELL_NAME()
>       dt-bindings: mfd: adp5585: document adp5589 I/O expander
>       mfd: adp5585: add support for adp5589
>       gpio: adp5585: add support for the ad5589 expander
>       pwm: adp5585: add support for adp5589
>       dt-bindings: mfd: adp5585: add properties for input events
>       mfd: adp5585: add support for key events
>       gpio: adp5585: support gpi events
>       Input: adp5585: Add Analog Devices ADP5585/89 support
>       Input: adp5589: remove the driver
>       mfd: adp5585: support getting vdd regulator
>       dt-bindings: mfd: adp5585: document reset gpio
>       mfd: adp5585: add support for a reset pin
>       pwm: adp5585: make sure to include mod_devicetable.h
> 
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
>  .../devicetree/bindings/trivial-devices.yaml       |    2 -
>  MAINTAINERS                                        |    1 +
>  drivers/gpio/Kconfig                               |    1 +
>  drivers/gpio/gpio-adp5585.c                        |  299 +++++-
>  drivers/input/keyboard/Kconfig                     |   21 +-
>  drivers/input/keyboard/Makefile                    |    2 +-
>  drivers/input/keyboard/adp5585-keys.c              |  221 ++++
>  drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
>  drivers/mfd/adp5585.c                              |  808 ++++++++++++++-
>  drivers/pwm/pwm-adp5585.c                          |   57 +-
>  include/linux/mfd/adp5585.h                        |  153 ++-
>  12 files changed, 1709 insertions(+), 1162 deletions(-)
> ---
> base-commit: 5b37f7bfff3b1582c34be8fb23968b226db71ebd
> change-id: 20250311-dev-adp5589-fw-e04cfd945286
> --
> 
> Thanks!
> - Nuno Sá
> 
> 

-- 
Regards,
Liu Ying

