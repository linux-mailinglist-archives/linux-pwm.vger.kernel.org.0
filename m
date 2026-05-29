Return-Path: <linux-pwm+bounces-9191-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACl+F6n+GGoEpggAu9opvQ
	(envelope-from <linux-pwm+bounces-9191-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:49:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B341D5FC7D7
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE18E300CC00
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911EC368D76;
	Fri, 29 May 2026 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jlmuDELP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E835AC18;
	Fri, 29 May 2026 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022869; cv=fail; b=H7eg3tajVa1uC6+lZs7bapb5ThXXtEbUXt1wxc9BDve992ByWFHylZN4DKy6SLTHVXpWvSinsUnAzWG8VOuvcPINVqOhc7wDjap4WfVMPwNbruNvrgmeHU2s+n4ii0YAkHuaHoaFEtQOB2iDTijrjMmdx0UjA7CO6D+SlfOLpSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022869; c=relaxed/simple;
	bh=bnHh+nJJfizBw922TUbpA2ThSdt/wvXTdGauyWyD10k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HJcyX90/yS2vY+KM1p4cnhKmaUxm0lYedkazWmVlLnCoP3Re7iKm74YDgKsFxwjD+5D3AJsnm4ZAcXXx0B6wv54Wgcgbc337dxWhqAJPsD4xLoyBC7l6J2MqNXXXS2zwQQXIOCNGDH+Pgr1j7gTs+HkNnjlmrM6TW31xfzp5y+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jlmuDELP; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGGG8Vl99nnpn0A1G85hlhEMComebgjxaS1XKXAdy7S8aPL61ffuLQ6AFfTLG5M4VtFFCBEyRspM8WvisdYdCXlBlZzRzfdB1CJz2xw/6YvmYLFf53bq0FsivDUg/c+i/SCu1zsfd/BM96SMg7YlqJ9jZxHthga0RETB0Jy34Gt4ChhTY6AO2WmbB0x/YH/Pno7SF45TUIJOL6FyTQPQ9VLDqLNJukQebDJ7ncrPOX73NMtSpLsL8OmG+hPaRH5uQFUF0IX36v9bMdxhjnu1vGiB6cmaJRrR0EPoDs1JZIbl0WJi+qv0eqV5ZC/jrhQd8kYj8XjEYTgZjdkbuQi/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+nHlOOjsydxn0JvLdFWWHzenjZTXj3sjzARouigz0Y=;
 b=PbB9wlWJFRNdM6RP5YArzK1cMyb3WBiBbOOgvrvWJKLhV3RuzxNoEHXQMwZUln9inDfhzhxAJP29hj2SpAWUP97LKSmIvwAqba2pSVlqQHuaKdvtJfr6VMz/nGzGz7vCc5t+hQPOc5H5VRpUo2kCOhi9PZ4PAwYWgPLW9fuqeSGgPeItvZjouVxBGpWHyuyTKox45pudeVx/z+RKIXzuMgaOzPMgDfEPMZ4Rb1vGX3sXNJh892TWFBkequqaESC9SDtIuKf490yQJSAhChmKmpgSJrm8qqBnzIYfXIMRcShRWGzN/CwWPTnVLa/ieZjvhlGlHgVz1YLQhTNnXXqEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+nHlOOjsydxn0JvLdFWWHzenjZTXj3sjzARouigz0Y=;
 b=jlmuDELPXEG0zolZ85UfXdKo9aN7meRDeGHfTejtfBri7un8oWdDM3CWsk4AB/lLyaxN9ZdTs/kf3w4uGOXJPVUxrsxeqfRFgHAWHI7booEDugsFWYFJg90HFqvwlcFTcTJQXyFVK7q5etNzBCoEddU5zNjMGK+TijY9jI3WkwtiZpVNL/dmuYfamCPwuk6bjnXtNCghAeOb1dpjan5ymqq7Yo81IeqSmKIV+VtOx+BUEKpnAQGfm114jgN2BRoelM43kd2tUA+Y2iWoDbiwH446wPZFxY8ybfNWw43f13MuGXYVv8zG0kpxrf/C9XzxGz6NpSqha8m1CyaR9swTEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 02:47:44 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:47:43 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v5 0/7] Tegra264 PWM support
Date: Fri, 29 May 2026 11:47:21 +0900
Message-Id: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOTQ7CIBCG4as0rMUMMEBx5T2Mi8qPZdHWtAY1T
 e8ubVxguvwmPG+YyeTH6CdyqmYy+hSnOPR5yENFbNv0d0+jy5tw4AoECPrkCunj1VGpPQMHwrj
 ASH7+GH2I7y11uebdxuk5jJ+tnNh6/UV4EUmMAkWLIWgUICGc+xRdbI526MhaSbyUspA8S2NqV
 9fS1HgTOykKKaCQIkupGSLXThqtdhJLyQqJWVpApqRRWtv/3y7L8gXdTNn2TwEAAA==
X-Change-ID: 20260303-t264-pwm-57e10d039df1
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca2a7ef-8bcf-4a99-323a-08debd2ca871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|6133799003|3023799007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wBN8GWObO7eEsX7hVtQawr26Nc78LrLNkgsztft8qrX6f/uN56Udfvz0eaZvSO40fAFQFiAJG0gLMwdJ09NbZWOEBPKcsXYwpP+EtTZCIQLvFrzKax5L7NT91itEhISMPc+GfmdS+OrCeQkmQjGPA2so3GhTA0JVopMI6rPW/i4lbLXQ1v4e3EEHcf7XAZEWJ1LdSIh2JMUUMvPGuDA5GLlnfZAnvMH+PM2ROrDBFvvwwx90tKTdYBZBtcr3hJDbSlkRrntmbXmOLTP0Cxt2yxFpS+3HUsSxhnfxj+gBNpVTEo9wNISOYJ69q0atDdswASIkpqhgxIiImX91qvBDDHFVy6hlByV5/K7M0EDYpoPxC2F3GhjRW77fNxWrLf0X2EO0OvxljMZsEa1r/Ejig7x36iE0N2RKpzBK7CQXjytqMyWBU4wCDLMSYULVcnIifwHTBHjpXeFnYgNnX9MdaJXz9V48tV22OSyF0dzoNwRfyTb9tSKIjPqxSQsUHPCbDnVtC1l59iX8aNZugTwIue9gHrpLgyE/lleFI3wCVoPdTBXYOZOyBvo10Gxw6Zt31yoZ1mzV/L5n0fkP4dJ+NwiggOBriS0zPswUFhFODAKLys5CUm4UZCM7MtnypvfmP9WklDNrc60nt5q8AIbrgAU5DNieFHpJPHpxAwL/F9n2Gqi0FFBvmDW4nZj+dxCW19ojfQ6lhSH29BgTGhMGNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(6133799003)(3023799007)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDJrNXdEOU0xb0FkL0hZSnM0cVVCdU1zd2tueFBQUk9pWVRGcUxHZFRCaE95?=
 =?utf-8?B?SVZNaTNiRWQzSFN0ZzJXSmp0Vkl4b0cwUTJjalptbTExNnJyOWVQTjlRbHN2?=
 =?utf-8?B?T0RZN25iV0hWY3k5RmJkZXVRZXg4c2h4Q0hLcC9RTi9yMDlQTHJlOHNHbjAw?=
 =?utf-8?B?YTVSME9mbEdZSExiZENqSlJ2VG50SlppMkw2bTJsRm8wb1dGZnBhdEZ3L3FJ?=
 =?utf-8?B?T3dHM20raSt4YmprbEhObkhPRGNNUjFLY0t5cERDSVR0N04wSkFnVWVHT1FU?=
 =?utf-8?B?dGZOMGJ0dUkrMGpUejE4eU9qWGQzbWcrSStsZlFhdXRKTTVKSjJUbXBRUXdu?=
 =?utf-8?B?a2k3S2dZSDgrczRRclNoanlYblpZSEgvSFpjNmZhdFFyajdmaEFIUzA1eC9W?=
 =?utf-8?B?MmhXbE84NVlHb0NJeGVFL2ZWOEtUblNaSEk2c24xV0haSElINy9ZTmNzWWh5?=
 =?utf-8?B?eUtwT1NrRnFwNUowVSt3anYyVitxQmh5RjRzTzZ4QTRsN2lSc1N5MnQ5ZmRI?=
 =?utf-8?B?WDZKWmJOT21mRTFqMzRuVWlVamIxblNRQkx2TkhVWlQ4b2lSck9MQmpsdCt5?=
 =?utf-8?B?d2dnZHFqRHRxNXFXQmx1Wmh5NUV0RWRsUSs1UVBVQlZVQ0RqSlhzVFF1UHdE?=
 =?utf-8?B?TTErdG03ODh4cDlKUXdaSnpKN0dUSHRiaSs2ZS9oMmptVFBMTWVPK1lJNi9W?=
 =?utf-8?B?cFU2dlBadk9NRGhoYkpHTXh6bXdsN2JJL2NBeC9rRzhMMXEvWHhrMVFLYmt5?=
 =?utf-8?B?S1pER0tWbFpTVVRDTVgyUjAyWWFDdHRvRmhHOEk0bWI5akVHaWdkbXphaUt3?=
 =?utf-8?B?OVQyek82dGszQTh4aG14VXlLenlJRmtLMGRvR0VhL2llOUZvTVlvbGZiN0g4?=
 =?utf-8?B?M1JzYUpZOE5oa0RwMmFDQkhvNnlNM2xBb1g0ZWExQzAvdnBKTjFJL3dqZzlj?=
 =?utf-8?B?aS9PYlVPMjRsMEFhSkh2dmpVVnE0NzVGZzd5QUNlTGNXM1g2REhVeDV6VHNP?=
 =?utf-8?B?VFBGQncxTzNmbWdxTzVBRC8wY2tERmQyZHB2VG5uMHN6TkJXUEw5K2JkVHZo?=
 =?utf-8?B?WHVac0Z6QzdOY2JXTmpacUFiOThSeWlSTFA2U0ZpdnE2YU1IS3psV2U1cElB?=
 =?utf-8?B?bUo2MU5sVnpvSHZrS1VqY2IzZUxzSWxVMHVJRVNvREhKNWtCTkFRcUFWQlpn?=
 =?utf-8?B?TC90a0d5WXNTUlk4U1Rka3M5V2JZWXpRQUhEclk1NXAvd1BnSzdGZmNFaXBG?=
 =?utf-8?B?K0trZlk5eWtZMlJHYmJ3MzQ3MmlSL3dUNi9XS3R5ZzBSWlVGODRmWXdyNW0v?=
 =?utf-8?B?YlI4dFR6d29HZXBPdGFzM1U3Q3c0dk5lZ1JQUkdLc05pTDUwczJKLzVTdFJ4?=
 =?utf-8?B?T2ZYeWM4ZWhzWUtqdG40UWpnRVhwdFZTUXZUZ1NuY0duWDBvRlk0SUxUL3BM?=
 =?utf-8?B?UWxXL3JOekpmejlGWExEeWFlcVJKUXMxcDhTckdIM0p0dVVPK0R2c1RrQ3p0?=
 =?utf-8?B?bnlWTXJyZjVpR2tOdGVYUFpiVWFORGxvOEowRmlNYjZBSXZ0eHppNjBvRzlw?=
 =?utf-8?B?YnFUQ0J0Ti9UQm5ndjRka21FWmhLUFNEZmFCNzJRdVVzL3BSZ1ZGOEJRRlNt?=
 =?utf-8?B?bnZ1cU9wSmxVeU9hbUNtYzFUc1hGcGk0aEpMalI4aFNYNWxiS1kwclRJQVhI?=
 =?utf-8?B?Nnk0Q242YkV5VVJmbTllYmxqUHdnb3hGQjBpWGtaR0h6SEFLTUF2anEyU3VY?=
 =?utf-8?B?QzYxSEU1SHVCRHJNWnd6czAxcnNHT25UaVRBTm1jV0RBckxOZ0cxRTRoR1lM?=
 =?utf-8?B?UVExam12VE1sTUZUYm5KdU9FbEZXd2hSRndhbTdJNnBmYUhIOURuUlI1R0JZ?=
 =?utf-8?B?TlZaOTI1bzBORk5Rd1p0a2pvektFVUR4RmNQTkI1cFVwOGsvZHMxbXd2TEds?=
 =?utf-8?B?OEpKTjNtQWIrWGdqa3lTUnRrZE5jTWRwTzRhYTB6d3FHTHB3ZUwvVk9Cemhl?=
 =?utf-8?B?ZXVka1VJR2EyMWJCZVEvdHJZNmNpdkNZbWdXZmVnNG1kTlZGY24yUjdTWnVY?=
 =?utf-8?B?alV3V3pnbE12NTJlNFJnS2R2Z3IyK2NaOGlGeVhrWU5nZVN4enVVMU9yc21F?=
 =?utf-8?B?SEZHMTliNXB0WUoxUHR5QzBrTzZocGFxME9jWFpQSjhKaEh5WXNJU2pHamkw?=
 =?utf-8?B?R3E0dFhjL05SNnNqNGJtcjR0Nng0WW9Iay9QeU1NaUk3SU9ad0MrblZOdDl4?=
 =?utf-8?B?ZFplZDVZL2pLb2djeVN6Y285U281K2NKS2FUTkNKRS95eXZsdjZFOXpKK2dn?=
 =?utf-8?B?UjBTNFhLNHp5ZWVRb0dFWTZVQUdKZ3krNnRFUXVBQ01OQndoUGxPMm1ySE1t?=
 =?utf-8?Q?ctgUnG4WPiDcxAT2PXlJGKEfbIzBkIVDrnjpsL8gunXpb?=
X-MS-Exchange-AntiSpam-MessageData-1: e8sdKX6UZ6BMtA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca2a7ef-8bcf-4a99-323a-08debd2ca871
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:47:43.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XJY3cDYAQy3klg8XQ/pcIfY4JU2f5xb6RkxhgQUPE7Jfx2okCP48W1te7j8gn9BNFhzkn8WBWRlHi5wZtol+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9191-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: B341D5FC7D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this adds support for the PWM controller on Tegra264. The controller
is similar to previous generations, but the register fields are
widened, the depth is made configurable, and the enable bit moves
to a different spot.

This series adds only basic support with fixed depth -- configurable
depth will come later.

Patch 1 adds device tree bindings for Tegra264 PWM (compatible
  string).

Patch 2 prefixes driver-local macros and static helpers with
  tegra_/TEGRA_ to make their scoping clear.

Patches 3 to 6 contain the PWM driver changes for Tegra264.

Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

Thanks,
Mikko

---
Changes in v5:
- New patch: prefix driver-local macros and static helpers with
  tegra_/TEGRA_ (suggested by Uwe)
- Squashed the enable_reg parameterization into the "Add support for
  Tegra264" patch
- Rename pwm_readl()/pwm_writel() parameter `dev` to `pwm` to match the
  rest of the driver
- Drop an extra blank line in tegra_pwm_enable()
- Reflow the code comment text in "Add support for Tegra264" to
  fit within 80 columns
- Dropped duty_width field since it was unused.
- Rebased on latest -next.
- Link to v4: https://lore.kernel.org/r/20260331-t264-pwm-v4-0-c041659677cf@nvidia.com

Changes in v4:
- Use ULONG_MAX rather than S64_MAX to avoid overflow on 32-bit platforms
- Link to v3: https://lore.kernel.org/r/20260330-t264-pwm-v3-0-5714427d5976@nvidia.com

Changes in v3:
- Fixed device tree binding patch.
- Picked up trailers.
- Link to v2: https://lore.kernel.org/r/20260325-t264-pwm-v2-0-998d885984b3@nvidia.com

Changes in v2:
- Added device tree binding and Tegra264 device tree patches by Thierry.
- Link to v1: https://lore.kernel.org/r/20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com

---
Mikko Perttunen (4):
      pwm: tegra: Prefix driver-local macros and functions
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Thierry Reding (2):
      dt-bindings: pwm: Document Tegra264 controller
      arm64: tegra: Add PWM controllers on Tegra264

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 ++++++++++
 drivers/pwm/pwm-tegra.c                            | 155 ++++++++++++++-------
 3 files changed, 176 insertions(+), 52 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260303-t264-pwm-57e10d039df1


