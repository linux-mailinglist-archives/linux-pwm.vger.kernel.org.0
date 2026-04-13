Return-Path: <linux-pwm+bounces-8570-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHSKNJRB3WkubQkAu9opvQ
	(envelope-from <linux-pwm+bounces-8570-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 21:18:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB53F291C
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A2D3007AD4
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB63B8935;
	Mon, 13 Apr 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tIlyN+K1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011039.outbound.protection.outlook.com [52.103.12.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2937EFFA;
	Mon, 13 Apr 2026 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107850; cv=fail; b=qVmqjxgb3B1PsMcI4jn0LhLQ1MTEZ5QscfqYvJlYJps2e5y/uESGX0nceBrieu/UxXXdDBZfu5Gkb7H7jGfyyW1M3uEfDuyL6a8o7vNxHcqCV8jxMUGquCVeYyKNCCuXoIBkLgzzqr5R6u3V8Trkxb3FQ1vAA9amalq6RHSCZ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107850; c=relaxed/simple;
	bh=ffd2xjEirb08z5miGr21BG8z8Y1JAYm1onJNK36zwy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oN0stfNPo1drPtCI7SccmCYUi5lVA/xq9/uP2y6uUYaTWxLgpTuHANRm+Q3nQnrO1V2F8bz8S0quixArdpOp5QSeu1RKdbJ6StVN3dkJwDoHxU+Ymz8fg+zmCVcKVMBhnWwGBhq8u9HwzVyjCVuuPw3g0UhP8fEKQSyVMvNNrcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tIlyN+K1; arc=fail smtp.client-ip=52.103.12.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd7TQsmePRdkPIx2/Pz/WPKyPY4bi5yZSpGs7pk8DCtf8JMNctWbbbyWINgvH9DzZIidofMLXFRNK8z6lTdRMwyN7LhpzlNsNnq3xqMlaH2Zram60W6Wku8XH/qxU5GUTSUy35jq2GgBAB4Wibp8oVvc4zmoRn5XAOZBCWByBBqeFrErj74hP+c9NstNL7Dpz31rV2krpG/otx0MWcsx3NS20o8fgVWJuP6zEDEIXnH6Wp2FdsJxHVf8CMTGuXmFtpT5ErARmFFVal0SErVYXbqd01Y0gXoXwZo8jFRcsPF7DY+7PwW6mZ2LplebLIfDseq8eQ0UZT1o12xb1ow3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax2D9a0izlfOTkUcjxnLUcuWwxXsEtMXjIMG4mSvCpg=;
 b=UKG0ZqYqk64Yp+7QGxUaBhUsaWS9itMnRwrJUi5qoK6LUt1ES8j8b0I0tg6jg5D9Z1orMbjmfWRz6Vfoo0LHtfStb/7f+Y/KdOsZrcON3FCKZBfAHrp3Bdvpz1j8TorBUqTOFat32e/y3P5/oF8GdoPDw4lLTpQbVG2P4KTgr3r7JkxNMXq6gk8YzYPdNNi+1VUJp785d2a0PqZEZ1vC/Py6IWCy3nwC8d6QyhRqK1NFakOTKO8WR+6oDcEC1hoeaQYZxQmkZG8VQ3T8wBm1/3pj4JsIPLTkN3zprPHqqgqKmlOOHNcT5o2mWEm+KZae1U4qQXXf8+pxAMjvvxSksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax2D9a0izlfOTkUcjxnLUcuWwxXsEtMXjIMG4mSvCpg=;
 b=tIlyN+K1wi4VtIlFhLpfWtn3Q+rwcum/RZUCtnQPMsBYuGMucIzzR0tBRfYtC0cqP+SZXS7N+2MhD/WjIXl8H6kXQtx0JuZdbV82EVMoY3VjqnYQaN2qyHdNwstLcnuni2HrISgfhxkgRxx5Cr0oV+JGywziJupo7p381R2DaBGJ/qJLizE0Rlhh1WgT3RdbuC2OgSFSBI9G7Z7JZ4TIDwq5OJOr2E90vmw8XIullK4a8ZtqV2D/0Cswcc1t7Ji1KXfrQPVB1sHLNvkeMozDXlrlJaxGYiZ04LWTsdAtoFNQgNORJX18PSF0VLmnd4+gM/E8v6t8a1/wwVpKDWH0/w==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA1PR19MB5641.namprd19.prod.outlook.com (2603:10b6:806:239::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 19:17:26 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 19:17:25 +0000
Message-ID:
 <DS7PR19MB888389B41E784995F064EE0B9D242@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Mon, 13 Apr 2026 23:17:18 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 2/6] pwm: driver for qualcomm ipq6018 pwm block
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
 <20260406-ipq-pwm-v21-2-6ed1e868e4c2@outlook.com>
 <ady2pLwiNT9FffF7@monoceros>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <ady2pLwiNT9FffF7@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR2P264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::15)
 To DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <adf45283-7255-4348-9722-fe7b3c0120ad@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA1PR19MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a0cdc9-6f2c-42f1-91d0-08de99914b1d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|5072599009|12121999013|51005399006|8060799015|41001999006|15080799012|461199028|6090799003|23021999003|19110799012|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmRBNE9ralhqbExkS2Vpc0NENU5uQWhaR3ZCTUt3SFBUcUtTY2YzSnJ2cGl6?=
 =?utf-8?B?dUFWZ3J1MDVRaUJvTnhIY1JEZ01nOG04M25YY0VPanpML0JLU1ZHdi9wOXNB?=
 =?utf-8?B?bGx0QzZ0WUhJYUEyZkpWTERzYlBPWklTUWxuTVNwRjE3YUVHdTJ0SU92NVhs?=
 =?utf-8?B?NE9VR2toOVVmQkdYNjJBL2hNeVZqaUd4dVNld2MwVit4a0dzUVpGTGk1MzZu?=
 =?utf-8?B?cHlaZHNIRFZ4V25md21taUJEYm5ZTjU3QklHaWpSR25JQWxlQS9JNldKb2l5?=
 =?utf-8?B?R1dNaERWNmxaZDBnOElDTTZkdDFDVWFaRUVlRHIvcm9uN3VqQlBwTWVqaFFJ?=
 =?utf-8?B?bVoxMitEdFB6MlZqNi9LZDRFNTQzZlBCQzBWWUgxdGFHWDBRUDdiUzVOWURD?=
 =?utf-8?B?N2pyeTYvdTVMYUNqa2pYSjEweEtKOGsvOGc4bDlVZ3BrMm5lMXFJd3dBOEZr?=
 =?utf-8?B?RWhYWnE1cWtiRVM5cHRXYXdkTG95a3lqWWNoUjNxeDhDdWZrVktaeXFaTlhr?=
 =?utf-8?B?K3E4REhyQUxhN0ZFRTdUS1FCZjVyOUZMWmhaQVVZSzIzV1BKMnoxakZXZUdI?=
 =?utf-8?B?NWpNRTRqcm9uWllmUVFCRlJYaHZsVWVBdzhHRDZhbFZ4TWZYRjRWWEJSa3F5?=
 =?utf-8?B?b291YnhpL2t4eUN1Sm1pQ0FMWTEvZ0swalh5b1JDNDgxYTZWdkVUNWJnTE1a?=
 =?utf-8?B?L0xsUEV4VDFkY2RaZ280eDBDQ3hJUGpoSHh5dmNPMG40T1pPWU16WWR6YkpB?=
 =?utf-8?B?ZXpnYnBsU3dIOHF5U2t0M2xOSEp6U1N5bHN6akxveWFZZGVUbDFBR0IzSHB2?=
 =?utf-8?B?M2FodmlaajJNZzloaU1Eek8xZS9SYUVyVEhCZzhoVklUYld3TDgyVGVRRjk4?=
 =?utf-8?B?WUdvQ2dvWDU0OGVxU2Y2d2paSGRtT0JrMXJUUjFHZzlzMEZnbmZDMDVkNjZO?=
 =?utf-8?B?VWJ1TFJmZ3N2MW5DcExOWThMWE9nckZlYUtmcFhVRk9hMUpxbFh0bWlzQlRH?=
 =?utf-8?B?MHhWL3ZzRFRFNXowNkcxaG1hT04yd0gxakN6a2lOeUh6cVZOU3ltSSsvcDlH?=
 =?utf-8?B?YzE4czFlUGdmTDl0amtyb3ladG1ETS8xbEFjTVB0b1A1OGR1Nm9QVHN0azZx?=
 =?utf-8?B?TEJVSFJVV2ptVHRrVlpmQkFzRCtyT0JFY0V0SUZMWE4va01TL2theW9DVGZu?=
 =?utf-8?B?UnR6UStEdTNJT243bDA3R1h2TVVHKytxVmNTVkYvQW8rdkNpWWFmdXRGTU91?=
 =?utf-8?B?c3VVS21oYkpsaVpEKzJsdHRNR25PZE1rZWc5dHQ3cWdkY0dLcXdnNlhPVlFG?=
 =?utf-8?B?Q2liNnlzbXNqczFSaTlDallvdXAvUXRHVjRjQWFBU2J5VlYva2pFU1d5OW41?=
 =?utf-8?B?UUZJZEZSTldwZURHbFFRdDc0T2hrTHYwU3VCVEdiSkd0K2hqdTdTSzZxWVkz?=
 =?utf-8?Q?2+O92/eL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDhYang1a3FseHpSTm84SWMydjZ3NlVSN085Y2pyS0xsdHVXQjI4VnZHd1Yy?=
 =?utf-8?B?a05aOHBWUDhSVyttSzJSZzRsd0R5eld2dkcreElyNWhUd3oyWDZNUlREc1lQ?=
 =?utf-8?B?SXpkYld3elJSVkF3QmZJb2M0a1Z5Qmh6RkdJTGRMU2dqUXQ1TWRaVzM5Rjdw?=
 =?utf-8?B?U1BoODRXSjBsNUp5TitaNHo1NTdRZ3RjTXFBdzRrY2dMeHVOK1ZZaFNmS2pW?=
 =?utf-8?B?QUlZZmJPUzdGd2FlK3VKdTZVck94a0U0Q1ZrRlhOcUpEYklMSHZzWEh4RGVW?=
 =?utf-8?B?WDVENkFJa09YKzEzRnpmOCttMnNDTXR3TkRYSDFhS296S0lyUm5jTzROY1Ey?=
 =?utf-8?B?NUhKRjdwSWphdEErMG5JeXFnc1pldk5aRER3eldEVGxPL0tYOGhXeW4xQzl4?=
 =?utf-8?B?SE1DOWVWWWt2ZExZQVdtdWtseW03MkhIbTVFTWkvb0pMZFdBb1hONWNOMy9I?=
 =?utf-8?B?OSs5Y3ZldlpibmE4TEVjSUl0UDF2bjFEV1ZMZDdxSzc3OENncEVpZUQxc2hm?=
 =?utf-8?B?blRmYmNMWGFRZTh4N0xxbG9mSDVodURab1VTS054bDdOOXAyL3ZHMkdtNjEx?=
 =?utf-8?B?c25VZFo2QWJPZ0pnejVCZENoWEdsdnc0RWZNTTBBUGVMQ1FCakJHbGJaMFpC?=
 =?utf-8?B?dGhhdFB2a0p1RER0Sy9ISXptaTNKclFmYW9ZZWtsWEE0U05LYnluRzZNRmND?=
 =?utf-8?B?OHgxL2NBSUd0QXBvWE95aFZuTkhYRWNBT2NnZWNFQys4b0FBSCs0ZGgyd0NF?=
 =?utf-8?B?TXlWWGE3d1pSeUtTNlgzT1hJTzNjcGQrNDlEZEo3VUJWNUszK0hyaWpwRnpu?=
 =?utf-8?B?L0hMWGdCMDZUOUhBbGxMUG5VeW5YS1QxclE5RHNaeVhGL2VzYnovUmI3VTNT?=
 =?utf-8?B?eWlPU0NvQ0VublVKQmdRQjRHNFhuUm1tR0RQcVR3Q3B4KzRURWN0a3FCSXR4?=
 =?utf-8?B?M1hmU3JCSThOcmxidTBlbE1lc0gxY2lhT1BYb1J6WWRaakU3Q09IM0V0RWJY?=
 =?utf-8?B?dTFzSCtZbnhubklwK05LRTBzSXlMWGx3aGV6Rmwya3R5c1JtVWllazM1Rko0?=
 =?utf-8?B?RG5na0taeWNXdEd0NzQwb3hsa0pBaTU1YVVsakp5bjB3VXRyTk1TRzJFUFVu?=
 =?utf-8?B?VHU1aDgrR1pyeFN5Ym9JYVI0RG96MFpJNW5EOG1GS1ZDQUZxSlRXSEdKWlNv?=
 =?utf-8?B?L2M4VFBVbnJRLzdiUEZrWlp2ZHNnNzRuMGh2d1VTQmRxRzlWRUNBaWlqcE9O?=
 =?utf-8?B?aGVSVWY3Q0treWRKczZSODMrZmxtalJUaVZjMEZidVl2djRreUs1N1lwT1J1?=
 =?utf-8?B?aHFhUFdkd0JIMlN0cmlEL3dPcmlQTGtCaVFmUnZHVWRYRnRJUC8rK2lpRkds?=
 =?utf-8?B?Qm9ZV3pERC9UeHh3L2MyRHpzbHdmbnVDUU9sbVBJTFRjNTA4YXFYSFliOGd5?=
 =?utf-8?B?cy9RUlpIN3lFdXdmSEpoV0wzMlFRYkd5c2txZEhEZ1ZoamN4Y05oNkg4UVM0?=
 =?utf-8?B?WVRpNGVDZW1FMklaRWJOc3FiNWtHQ2hTZVBqY2JiVU9JSHA5VVl5TzVoSFUv?=
 =?utf-8?B?WmJBYVZJM1lzaXRmcDlKaWdjeTJxcEdSc2x0ZHhXZDVhZEJmT0Exdjk4c3R1?=
 =?utf-8?B?NC9vV1VRbGxOb2dSdmJhUmVXbGZRNkxacTlDK2tLSFVCQ3h1bXFLQk02S3Q0?=
 =?utf-8?B?dkExSERWZmk3SUx5WVM1Mi85ZnF6MjZvZTBHZXpQenMxOWVnbklwc1F2aU9E?=
 =?utf-8?B?OXkyWnpkbG5mK0t0UDZRL1JqcGd0TzJNY2xUY2sydTRWZXZCM2xTZE5XMGhr?=
 =?utf-8?B?L2tCUzNvTzkydDRLLzV2S3pzZDVCOEtCU3M0dHluV1B6aUpySE85WXR0Q21B?=
 =?utf-8?B?SEJQLzZaWU5XV213NzhhOFg3T0ZRUFU4WkdGSCt6TTFSMHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a0cdc9-6f2c-42f1-91d0-08de99914b1d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:17:25.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5641
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8570-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siklu.com:email,quicinc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DS7PR19MB8883.namprd19.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 3BCB53F291C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello

On 4/13/2026 1:35 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Apr 06, 2026 at 10:24:39PM +0200, George Moussalem via B4 Relay wrote:
>> From: Devi Priya <quic_devipriy@quicinc.com>
>>
>> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
>> driver from downstream Codeaurora kernel tree. Removed support for older
>> (V1) variants because I have no access to that hardware.
>>
>> Tested on IPQ5018 and IPQ6010 based hardware.
>>
>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> 
> I have a few remaining nitpicks. If you're ok I'll squash the following
> diff into this patch and apply it:

Just applied it to my own branch, all okay from my side. Thanks for your
guidance and support!

> 
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> index b79e5e457d1a..65af19ded72c 100644
> --- a/drivers/pwm/pwm-ipq.c
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
>   *
> - * Hardware notes / Limitations:
> + * Limitations:
>   * - The PWM controller has no publicly available datasheet.
>   * - Each of the four channels is programmed via two 32-bit registers
>   *   (REG0 and REG1 at 8-byte stride).
> 
> This is to make
> 
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
> 
> do the right thing. I know "Limitations" isn't a good subject for this,
> but until I come around to pick a better marker, doing the same in all
> drivers is good.
> 
> @@ -44,13 +44,6 @@
>  
>  #define IPQ_PWM_REG1			4
>  #define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
> -
> -/*
> - * The max value specified for each field is based on the number of bits
> - * in the pwm control register for that field (16-bit)
> - */
> -#define IPQ_PWM_MAX_DIV			FIELD_MAX(IPQ_PWM_REG0_PWM_DIV)
> -
>  /*
>   * Enable bit is set to enable output toggling in pwm device.
>   * Update bit is set to trigger the change and is unset automatically
> @@ -59,6 +52,12 @@
>  #define IPQ_PWM_REG1_UPDATE		BIT(30)
>  #define IPQ_PWM_REG1_ENABLE		BIT(31)
>  
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field (16-bit)
> + */
> +#define IPQ_PWM_MAX_DIV			FIELD_MAX(IPQ_PWM_REG0_PWM_DIV)
> +
>  struct ipq_pwm_chip {
>  	void __iomem *mem;
>  	unsigned long clk_rate;
> 
> This is just about ordering definitions taken 1:1 from the manual before
> driver specific stuff.
> 
> @@ -95,6 +94,12 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long val = 0;
>  	unsigned long hi_dur;
>  
> +	if (!state->enabled) {
> +		/* clear IPQ_PWM_REG1_ENABLE */
> +		ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, IPQ_PWM_REG1_UPDATE);
> +		return 0;
> +	}
> +
>  	if (state->polarity != PWM_POLARITY_NORMAL)
>  		return -EINVAL;
>  
> This ensures that the PWM can be disabled even if state->polarity is
> bogus or period and duty_cycle are out of range.
> 
> @@ -102,7 +107,8 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * Check the upper and lower bounds for the period as per
>  	 * hardware limits
>  	 */
> -	period_ns = max(state->period, IPQ_PWM_MIN_PERIOD_NS);
> +	if (state->period < IPQ_PWM_MIN_PERIOD_NS)
> +		return -ERANGE;
>  	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>  	duty_ns = min(state->duty_cycle, period_ns);
>  
> This is about correctness. A driver is expected to never configure a
> higher value than requested. (And otherwise I would have converted that
> to clamp().)
> 
> @@ -134,7 +140,7 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	/* pwm duty = HI_DUR * (PRE_DIV + 1) / clk_rate */
>  	hi_dur = mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
> -				     (u64)(pre_div + 1) * NSEC_PER_SEC);
> +				     (u64)NSEC_PER_SEC * (pre_div + 1));
>  
>  	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
>  		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> 
> Just consistency with the period calculation
> 
> @@ -144,9 +150,7 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
>  
>  	/* PWM enable toggle needs a separate write to REG1 */
> -	val |= IPQ_PWM_REG1_UPDATE;
> -	if (state->enabled)
> -		val |= IPQ_PWM_REG1_ENABLE;
> +	val |= IPQ_PWM_REG1_UPDATE | IPQ_PWM_REG1_ENABLE;
>  	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
>  
>  	return 0;
> 
> Simplification that is possible after checking for state->enabled early.
> 
> @@ -174,7 +178,7 @@ static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
>  	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
>  
> -	effective_div = (u64)(pre_div + 1) * (pwm_div + 1);
> +	effective_div = (u64)(pwm_div + 1) * (pre_div + 1)
>  
>  	/*
>  	 * effective_div <= 0x100000000, so the multiplication doesn't overflow.
> 
> Again consistency.
> 
> A nice followup for this patch would be the conversion to the waveform
> API; just in case you're still motivated to work on this driver :-)
> 
> Best regards
> Uwe

Best regards,
George


