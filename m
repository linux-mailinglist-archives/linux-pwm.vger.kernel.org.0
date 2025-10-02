Return-Path: <linux-pwm+bounces-7386-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7108BB2577
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Oct 2025 04:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7136F426FDD
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Oct 2025 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2E14D29B;
	Thu,  2 Oct 2025 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayRPN5oL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5614A09C
	for <linux-pwm@vger.kernel.org>; Thu,  2 Oct 2025 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370803; cv=none; b=jte87PLz3MbNvX8VVtg9Ev74Bb1PavZU5VeLp/kaL0PbBCbh1Srp+paB2jnUWreikstYo7kQRieVLhMYF+Bazihz0U1oMEJDDoHF3UxJAIXUFKmhluXIXeQWTv5pWagRfzNkDtXfmnLWGrLCbunBTTda+VYm4lfF9gRfgaHw7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370803; c=relaxed/simple;
	bh=kV6O/7xr+ozWsJJbk2YUXyEa+iKmtdPky6IvJGU1gXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flKOsZigvTeGzRWGyMi6YI4uxMSF/rbkT7ZHOb0/KNMQ/Z33/onqhMVdpi7lC+wYIidMQQVXq0KC9QGBuAlOtQZIjmUuiEWBerJxVdBM+jgmC+FhIq8jfmZso7OuX3VCe7qqFqxBg8Cktfk/h1rEp1A/6nr8ck1lsxp0LAL5zaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayRPN5oL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic5vs005969
	for <linux-pwm@vger.kernel.org>; Thu, 2 Oct 2025 02:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Es0e9pv5niRRIId7gi4sYI/e
	tClgkXkV5fl6Ta1xdZw=; b=ayRPN5oLVePtSw7ld1xYRluIOFQLJk5WFV7us4Pw
	56WBYICkCiR+KarEqSVJg2SeC1aaCGbfAhJIZhfljSotVzGBylrvyf5T9pvBp+1K
	iaSjmO0EKC+0qXaCmIwN9bHOKHSIEFAb5x65o0Dhe2XguIgkSXAKk+14LZgEo0xG
	sTyYc4T1eqKxQlM+BW5hanIY5vkAvdmjOt34wqmnNvSDW0Um4iyHpmUIJAwlxiu+
	eXsHIVAesy7SAeWnvkgkSwcDw7TAsa3cvZ0D2qUYPuy1Xzfe+4xbCGHi79WTJwE4
	xxyKdcNV0E8O7djFg1GCkMFchAK2E6M+lSMRtB1148QSfA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdp64w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Thu, 02 Oct 2025 02:06:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dfc05dec2fso18930791cf.3
        for <linux-pwm@vger.kernel.org>; Wed, 01 Oct 2025 19:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370800; x=1759975600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es0e9pv5niRRIId7gi4sYI/etClgkXkV5fl6Ta1xdZw=;
        b=h4wMSl/rCvNyjUSZytcJ/yfxgU9OyGLCmN/Kf9VrSDMddWi3WLmbOoUqpUeojOjCLX
         bFWZI6x1amVQJ5xpMM/ZczcYA+kcNc60jAt6K87Ut+OXM0tcrRkUKZAWLfBlqfaH76Jh
         z1buyeaDhibdCufEeWZc/ToZpHDAssIpqDsxvN/gDYO4tmvUJsMxXWDTq9T7u6wUlQh7
         j8OAYyEcFax71PY0j0e+UeaZwq37hPAAt0HYED0N55hni3y7JYmxUacwrtWZ7oE4R389
         D3XJzlYSi5f1urho2mTuJoHy4tUNm69JJl7LZvkrbWrH0RNkroIst+ml9WTIKYWypSgl
         w80A==
X-Forwarded-Encrypted: i=1; AJvYcCW8Re170n7TWjPhXXS8jiHPxS5Ug4VPeEeII1PjjShpOpNbcxeXkKcnpq+p5EbQzKEC3B4iFsfhqkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVO01j+kesx3TzuRqVnqjlyu1OD0UmSOL4PCERVSHqrY3YM2nl
	lQMW9/5lhMDDnav04lj0iOU55DfgGoHkIHDh8lmLnGA2VIia1QFQl9HBUTkf6+UxOMXzLH1i/bn
	RUlo/Jh0zuOeYgOciHJf9VOiMT7ldUE8Q0vXAB7LrXJvov2atGFSHKdiOJF8d0hU=
X-Gm-Gg: ASbGncuexlHKvgjpB7lfvsx/fPIIscdEdFEaJW78eH8orMYt8eb3si+5Ovk6sLHWMsU
	HhmZpc3XNaySMbMZkwOuaGYptzepw7LyQP8aO8N0Hv+etoqT+qeqzxFAPKM370lCw4w01siOFaD
	0qb7Co/ojVjOPLmOsJ+ttyvmAguGzOY5ilhcdNudDnSMrVDM7DHtfayc0haReziVPtdmcIRd/Vr
	RLEmNNYWiEi/TH/Z+Us6/AOtRAMtuYJ58uCwPcXpUdG5sFyjao6VvsD4BV2+LqZLynQ0tI9tXJN
	evg7AxphS3a2f1YEQjgz3T0heGAow8ZILWCKVnOQGJE5Qdo8+scXP2jnThhBZ1emOoffW7XIrV/
	djrfU0DtPVcJ7VBgUVonfwYqwtu1Cw8vnMXkRMzq4FSFbXy5qoRp0Gp7fvw==
X-Received: by 2002:a05:622a:514a:b0:4d8:2245:e247 with SMTP id d75a77b69052e-4e41d8a3201mr84427381cf.54.1759370800135;
        Wed, 01 Oct 2025 19:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvECAJBZExthaTuqlaw1tux8fLUgY4bEAQ97CI/RX30reaxMonreDyaN02w4PUzNOLGdujtA==
X-Received: by 2002:a05:622a:514a:b0:4d8:2245:e247 with SMTP id d75a77b69052e-4e41d8a3201mr84427151cf.54.1759370799692;
        Wed, 01 Oct 2025 19:06:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d33fsm374381e87.91.2025.10.01.19.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:06:35 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:06:31 +0300
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
Subject: Re: [PATCH v16 8/9] arm64: dts: qcom: ipq5332: add pwm node
Message-ID: <fbkpfbgkn6ycwfdmgqy3hzqu2lg2tin5gsw5k7ezn6o5fqfa54@hv5ge3qzojcl>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-8-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-8-300f237e0e68@outlook.com>
X-Proofpoint-GUID: eCAT82aTo57_FNSNpksdiWv7JP6ntg8z
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68ddde31 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=W8KEJANZPcvdmftmyl0A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: eCAT82aTo57_FNSNpksdiWv7JP6ntg8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX+NghfxPpKOXf
 HUOxsrOyRr7hRIQb3s/gXSaTmjMdbKMWPaEsvCW4RNM+AB97R13aQ0mbqOXSInU1yAPObUsLiMP
 LeZNjl0xLkcFiAhKNZOIuTFBQdrsq/xXFkAblGiFwPlWEj2Ltj8HAGiOQxqRxaqkN/c5maNiCia
 XmR7tSLP39AFTc9fy69o2um057e4CRpJInlGHiUgyl6nIGcn0ljjkf0w+mv+lxRnjKv9laBqnMF
 c+L+Q13cG3OG4o+ox2fi5lBbdlpBYmddDlvLNaQU4sd90PryYoaVAtac+ulSeoEXO5LsT26Y7BA
 W4IxEF4eJjRr5h93GQpY99Ti+if+jNHb5Lo43476HnydGPHMobOaCq2rMrvnq06tWnaFabAKkb4
 rvNw23j2iNBNXeOsJ9toxXgR1S44fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Wed, Oct 01, 2025 at 06:04:24PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ5332.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

