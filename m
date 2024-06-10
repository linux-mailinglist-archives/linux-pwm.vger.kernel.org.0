Return-Path: <linux-pwm+bounces-2401-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F29024A1
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8211A28972B
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FB132132;
	Mon, 10 Jun 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJASzE0i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C486126;
	Mon, 10 Jun 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031119; cv=none; b=e2+aw5lt6YgSl54dexG/THtiJvDPz6a4tDBaI/ITAaU6CwkomymeCW3spOGkbZ7vMFjWs7BoYgTDmiDEhxoYSUBfuE5DbbXr6uRhuthBOVukUB66B6m5Y61HztHOd4C6ukQZCAv6cmOq3QBA3AXdGzvmVhYtkQ7rBH+MYvPk9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031119; c=relaxed/simple;
	bh=J7ZWOqXKkyCGzFLryf6VAuDFNJZDiEG9zvqZplCGJVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ucSuWs7X118ug2kgDe8HH1eftrxLSS/gYx7iUr2cG4JaELsQu1OvSlYXIdbeUP6qDPTqWOnUu2kUtJslGAF2ml1/8BLSS3j+2PnA7JHVPvBaVQqSSVRKv/ZRLrOY94nPQ8jCoOxvkB8KLmQH4aZR9ACqaW9HL+vEGOAMMCyyyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJASzE0i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A1k2N1014061;
	Mon, 10 Jun 2024 14:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	773pQf40WEFcUjWibw27sM8RmGgqxd1j76oenfdCpJQ=; b=FJASzE0i3yei5LWQ
	FhK4tTd6kJFDiPloLmDqUniEEBQ3MJ3HQLgMVGw9slJkTEgNvFSbY0os5SSFyVj0
	cEPX1IhxR3jitqveKagXYEa2EGR/zHi/4GoozIbIJGAZUqREU9g3sQpTM+TS8//g
	abE9EtMwtgDDUtF6cCrBaIFsFoTnPmUTSzpqRWLBwafkDviRDAILf0mHO9dbhKOz
	RZ3iaPgNPUHUFjZ4LPdXArkAJ1a9b4cRqO8sA0ko3rU2pn/lZ74h1/syJPTRCtvc
	LLYnbhcWCXGA91x6oaG2bJ/zUcIXYv9P65BLzyOOMxFNqb+G+mp6yn+UEVOKEES1
	Fm4JUg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymg2ekxv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:51:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AEpfLP006698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:51:41 GMT
Received: from [10.48.242.196] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 07:51:40 -0700
Message-ID: <e730c786-86b9-4362-986d-cfe37ef33753@quicinc.com>
Date: Mon, 10 Jun 2024 07:51:39 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam
	<festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
	<alim.akhtar@samsung.com>,
        Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>
 <ca6b4ce2-4ebf-409d-b87d-2024445b9392@collabora.com>
 <g5u7xk2l625vu6dxleonlmshnwqoge5fiaigbqlcedayu2rate@o4vgz7g27vlv>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <g5u7xk2l625vu6dxleonlmshnwqoge5fiaigbqlcedayu2rate@o4vgz7g27vlv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _rEb0ZrrPJdfv-EUvA8XxWBacA4VddRP
X-Proofpoint-GUID: _rEb0ZrrPJdfv-EUvA8XxWBacA4VddRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100113

On 6/10/2024 2:05 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jun 10, 2024 at 10:06:49AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 07/06/24 18:02, Jeff Johnson ha scritto:
>>> [...]
>>> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
>>> index 19a87873ad60..0b5d68a90e83 100644
>>> --- a/drivers/pwm/pwm-mediatek.c
>>> +++ b/drivers/pwm/pwm-mediatek.c
>>> @@ -395,4 +395,5 @@ static struct platform_driver pwm_mediatek_driver = {
>>>   module_platform_driver(pwm_mediatek_driver);
>>>   MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
>>> +MODULE_DESCRIPTION("MediaTek Pulse Width Modulator driver");
>>
>> MediaTek SoCs have got two different PWM IPs, one of which is used exclusively
>> for the Display PWM, and it is located in the DDP block.
>>
>> So, there are two PWM IPs in one SoC:
>>  - A general purpose PWM IP
>>  - A DDP PWM IP
>>
>> This driver is for the general purpose PWM IP.. so, please, can we change this
>> to "MediaTek general purpose Pulse Width Modulator driver"?
>>
>> After which,
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Looks like a reasonable request.
> 
> @Jeff: Can you please resend with the suggested change, I dropped the
> patch from for-next now.

No problem, v2 sent.

/jeff


