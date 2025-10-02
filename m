Return-Path: <linux-pwm+bounces-7385-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA6BB256B
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Oct 2025 04:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B262D175EFB
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Oct 2025 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBB155A4E;
	Thu,  2 Oct 2025 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvRi8Txb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91613D638
	for <linux-pwm@vger.kernel.org>; Thu,  2 Oct 2025 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370779; cv=none; b=mBagQ4Ex/pQGlkf7EdHLxt7VHlZworTxZi2mP8AYLJXH9w8jvyAAkLCkaITOHguLxRbkgXm2zfIW/n5tmdB7o4pc9qRSCQyb3DCTb/+d9yB6QXs1bhlkxjjpFB2XlInunX5K+09cSWstTioX32+LPbZL8M9tNhe6SQPANoocg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370779; c=relaxed/simple;
	bh=xhmmYS8ldwgF9fQ7gsr60vedDHtDIGYmWzukO0O0yUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY6KReQpctvpclaic4JIC8Av25ESFkH4oTaHJvAmV3fmKcRfoQNwwpqYU0Vcw9axZjeTPWdGkeMIFlqdYHwrLLJrlPKIVV9/AiohxLqLzIJ3Lq9w3CUIxYHi1VO7fGXJ4b77KaIzDIVmoeJS2HyP5871PsrwxLMIXF2hAOL+EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvRi8Txb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcPBo001079
	for <linux-pwm@vger.kernel.org>; Thu, 2 Oct 2025 02:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NlrjA10uPReWQuwGTVDaUugX
	z53bpDjEyE/kchavb4E=; b=TvRi8TxbgWvgUo1WWy2/Rvo+DOvuAqmh5Vbudg+n
	vwQueuWQM0xHvxK3pIciNagT63m1Ela/+i5u3YBwLtZPijpF8DFXgqgZUrKBFfVu
	CCdu9K8spiW2Tt4gj+y8jzNzGr4WUHA9wPhHPXIYvLAvCmLgELAc9yzS9FWtfThd
	9FMCSRLIAepxmYa7svw+AJpEs/u8y12Y8vz2+spJ1KnjZIxjeA7bXZ0idK8mJ5oq
	nLI56sCsrE5h+CDlO23shFhJzBE947oYglpWgmxV/QHqd7M0u1/ZOz81KKnQmBpn
	2JO4Ov6V+k5ZFEU2AvWP+G16JjMgT1vI+YacIFhVodSRDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5xj1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Thu, 02 Oct 2025 02:06:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4df7cdf22cbso44513931cf.0
        for <linux-pwm@vger.kernel.org>; Wed, 01 Oct 2025 19:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370775; x=1759975575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlrjA10uPReWQuwGTVDaUugXz53bpDjEyE/kchavb4E=;
        b=FI4rMiT0xHIn2Y6qC3wAkIfD61Sn0nEr/c23Rl0zNtlG7/aAdssEeyxVnZ0y1G1OUW
         xaj1fHUMGVWS89mVuKfuQYEgj5GxrD0gXhjsX17a8dA2MgtthmASnZb+XT/vV+QyUxV+
         0aseo26mgYa3/Yrj6b7Xcd14Yu6n3lJD2XN7hRH0T7zNDDOKGzfvSwdhgrml64spr2nq
         /Iv1n8rX//LMcRMF+DvGbezB8GcOKrYgll0a/K8Kk97BvNsyTvrECXYrYX5GfN9gNZhJ
         U3S+KY2/wiGOHSpby3tzeYfugq409aZgOTcMVsc0HaBjQYd0DWNYFBdYgo/XT/vFAfdz
         KNCA==
X-Forwarded-Encrypted: i=1; AJvYcCUObtjzmYQVr7i66mSGq6bctWxd2KY8vm+YM4HSkzy3aj4kkAXjCCyh+xmL9GRO1BUiVMyLAsbcPM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYT4tDplfYPMXohi3ZHNrTjSGOTWg+kckNl6Lg2PlJwrr3Z+o9
	tOtHUCYmUTFL0BFmx75giX1kTuzspbvkJni/CHqmbvay20vWXdHlxkSnKr0f+NQ0o9XPBNY6PnR
	YqzKzEQyNLTCI/SwaX/EgVJha9hfDocZe3d7GOXYjiQMuKUwDlEXHlxFb25VXNzg=
X-Gm-Gg: ASbGncuaFyF0sBd27q7upApxaIGDXF4OUY//nWNo43/PXeiVNUIj6Sok12A9VmqszVp
	YStnuDw3v72VZXo2QRk4MrwifR5jNkpowljzomp4qCIiyF/3xmvJmbHzyLET0VIqgvocB2gICtJ
	tKRKD22kTuBo6QyVLoOrO48ASgTtOvJtZ6p49UzxKbux0EQ+z0c5Vjmc0TxJ938G5sqB9tJNBK4
	WXr6l+QhsYS5ADnocr3s45iNyWqpGYV9YUWOtKfDAC8WA8IBlDQUK4vP883QV1loKGTvIq/4bax
	Ut9PZnh7wVM9IOuwaZ/QzNHCbFNuZS0YPupRRaKMwQf0AI4FV3Vq2DgQEmDzyh3tlrcgzDRDvEW
	uLXtPF2bCsigdwrwGdMhg3ptE+U44C4yj36p1escDwinhoVufHgIBpXZ1YQ==
X-Received: by 2002:a05:622a:288:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4e56385cc7fmr27596651cf.33.1759370775662;
        Wed, 01 Oct 2025 19:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnmEEod2O1/0uzDDtH9aXoT0ph1E9BnSq1tEA93bbQlG57iNx6XpWIS3N1TkSkZ765Y5FXUQ==
X-Received: by 2002:a05:622a:288:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4e56385cc7fmr27596291cf.33.1759370775171;
        Wed, 01 Oct 2025 19:06:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d3e6sm364500e87.63.2025.10.01.19.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:06:13 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:06:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 7/9] arm64: dts: qcom: ipq5018: add pwm node
Message-ID: <ya7h4l2cf3mx2to5pyw6ap642xvqjbhwv3ugcqqp55gaq736tx@ksnzcbeb7bvv>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-7-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-7-300f237e0e68@outlook.com>
X-Proofpoint-GUID: hlfTKN_1u_pLqm528JqOdR_MwltoyfaK
X-Proofpoint-ORIG-GUID: hlfTKN_1u_pLqm528JqOdR_MwltoyfaK
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68ddde18 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=pgNS_SGoCABwbyoThYAA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX1nwByop7MK0y
 6oyTY3x81FWzRV+W/L8qCrbyc7UWMh+vYs+N8CJ00jFZLpD+DHGG4eENT2/vpJmMEMUUI4ahaH8
 NQ+i31CKf0GBX5TCg/MB89cK0XbTCWuIOZ9uEDh17aHIEYIIJhEzJTkp6if+sGCfnEzTGA3ubYc
 XiZ+Ic2QxoxdL6e6U63wHMBPPwuwF/aAfKpEjgA15ouPUDGfhpXz3/8154GQ9aS7D4gAuxP5iq/
 gnQ+hZsYgZwz3SXDng4b9iWpy0HzjgncI3N7RMbL5TbqXCwgidwddFW8KgKfhbRydJzrwPouDxd
 dPs+4CPFdDcskOS7CNgRM7Cj9Fwjv8XUI2L71oxV5tewEMlWgrHK5uxmxRcYSB9qvMwr4kBJs6c
 z6ApC0F/rNV1+3DAZ94FaNT2M8pGiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On Wed, Oct 01, 2025 at 06:04:23PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ5018.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

