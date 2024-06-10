Return-Path: <linux-pwm+bounces-2399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC5902460
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294F01F261BE
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A0132108;
	Mon, 10 Jun 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pw43uUed"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4D132112;
	Mon, 10 Jun 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030682; cv=none; b=Rs7nAcArPd9KFXe5tv53DOqhUEYgGLPkxikjvuR6HFF67X+xVF7Bxx+FCkh/25vgNlcWMANK27WeW4Lzt5IUnsrBX4fS5tLDzn77NKNxjZbgCbbq+k14WmdNg+xSoJNb/XXiTMur1oyn/H/THElHb/Rr6SPwpf2t4C/KZV5M4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030682; c=relaxed/simple;
	bh=eY9F5kq/mdlMa6zRjS1NBDAumKWUUH16eUTQ0RBgBOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QVq5HNmh/aOrT0gbXCUkBJbxZzLCgrDCr/YTiFTQpSnLGl+wr9pwO9x+QZ0zK2rSwD21Bpyh68c5VrZDy38kgRfsWHl7/ArJ68FdFoDkjM/jUdUx5bJjVhPn1371UOELWDt9vHUwG7Hi7UQDdp01qmHzz+GPQ9+MY0Gw+ntHARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pw43uUed; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADUbtR029624;
	Mon, 10 Jun 2024 14:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YerxaNiDrqT++v3tBHV72ahDavLdzSNSM69xaGAmvMA=; b=Pw43uUedZ8KuOXS1
	/oNwR7m0GP/Kt6W/0Fbq9TGDv3JR19mDb2ibvMKGY/lln1YHY8iKFdt9Az9Fm1fx
	X74gWD12Mrm9hbEcYMbHaXQ9X8f0jJ4EVr/jRZt6PGKDmRT6Y1XHSWCmDuv5RAzV
	6UKlt3qxurrWT5PnoMtb4ilDlQbOd1qlsl+c5QYuILroXvvpFfX6YlOQbxDYNMG/
	c/VJyVK03aBcQJ5TzjAwsQLtZOsHdCRX/45XmaNPNpmHKqzYOGfpx6hGF086Ubk6
	fzeb6Oo5PMLhriIJaXJXzaY7Tz1mJgFl38jHVD4XPY8IPEi0up4hWlGBmc4qVLqv
	KoOsgg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymea6kwcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:44:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AEiIwZ012751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:44:18 GMT
Received: from [10.48.242.196] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 07:44:17 -0700
Message-ID: <ea5c6e03-3821-4808-9681-ea5576c65391@quicinc.com>
Date: Mon, 10 Jun 2024 07:44:16 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>
 <ca6b4ce2-4ebf-409d-b87d-2024445b9392@collabora.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ca6b4ce2-4ebf-409d-b87d-2024445b9392@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BZzjFM6FFRhPIg51RXBqh8PoY2xZ714Q
X-Proofpoint-ORIG-GUID: BZzjFM6FFRhPIg51RXBqh8PoY2xZ714Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100112

On 6/10/2024 1:06 AM, AngeloGioacchino Del Regno wrote:
> Il 07/06/24 18:02, Jeff Johnson ha scritto:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx1.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-intel-lgm.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediatek.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-pxa.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-samsung.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-spear.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-visconti.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> This addresses all of the issues in driver/pwm
>>
>> Let me know if you want any of the individual module changes
>> segregated into separate patches.
>> ---
>>   drivers/pwm/pwm-imx1.c      | 1 +
>>   drivers/pwm/pwm-imx27.c     | 1 +
>>   drivers/pwm/pwm-intel-lgm.c | 1 +
>>   drivers/pwm/pwm-mediatek.c  | 1 +
>>   drivers/pwm/pwm-pxa.c       | 1 +
>>   drivers/pwm/pwm-samsung.c   | 1 +
>>   drivers/pwm/pwm-spear.c     | 1 +
>>   drivers/pwm/pwm-visconti.c  | 1 +
>>   8 files changed, 8 insertions(+)
>>
> 
> ..snip..
> 
>> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
>> index 19a87873ad60..0b5d68a90e83 100644
>> --- a/drivers/pwm/pwm-mediatek.c
>> +++ b/drivers/pwm/pwm-mediatek.c
>> @@ -395,4 +395,5 @@ static struct platform_driver pwm_mediatek_driver = {
>>   module_platform_driver(pwm_mediatek_driver);
>>   
>>   MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
>> +MODULE_DESCRIPTION("MediaTek Pulse Width Modulator driver");
> 
> MediaTek SoCs have got two different PWM IPs, one of which is used exclusively
> for the Display PWM, and it is located in the DDP block.
> 
> So, there are two PWM IPs in one SoC:
>   - A general purpose PWM IP
>   - A DDP PWM IP
> 
> This driver is for the general purpose PWM IP.. so, please, can we change this
> to "MediaTek general purpose Pulse Width Modulator driver"?
> 
> After which,
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
>>   MODULE_LICENSE("GPL v2");
> 
Sure, I'll update these in v2

