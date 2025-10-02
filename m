Return-Path: <linux-pwm+bounces-7384-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8140BB2562
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Oct 2025 04:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFB3B8F75
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Oct 2025 02:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8687078F2B;
	Thu,  2 Oct 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAz5CVLc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5434BA29
	for <linux-pwm@vger.kernel.org>; Thu,  2 Oct 2025 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370753; cv=none; b=IcXxDf/ebtUSoIe5gRlbVqOJKV1Wd7TUi6ag1+Ka2dera2f0XZ6OqqTh2wnelEoXtYAx4lz6Fq4OpxxstnHmbpJTYd0R7+wS2L2a4QMDOvZK6eYaCj3wJNMnl8IPGMgSzHJ7z2GHeOPvzCR3VDmnGUO5Q3Bh1iocF74xkwm4To8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370753; c=relaxed/simple;
	bh=l+FS39zuBet15cZverAsMFAIByn00DrueloAdz9PJpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KshyjoKa3/QDC2jhtiqCm6FmzIgrwhkgJ80oM0iKJ1AWTb+sHOefMZYYvI9bSZtC0mZN/WidIPmkCKEWtYmgBHX7NoagwL25cnLrS1vNqOvYxEr3UOVPKYa6Ie5K02/QrgNzfbOwAU0ghe8DSeTIbLF1Sq3cMK5OxAv81IBVzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAz5CVLc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic5l0017871
	for <linux-pwm@vger.kernel.org>; Thu, 2 Oct 2025 02:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uz1KimgaPZysBciMTXlV3quW
	2Pafl+wJkK/SdLwaPRI=; b=HAz5CVLcqd6snzgMN3wupPDdbrO9CO10y6s+mb2a
	jTBQkGCJemULnonhbChlDoh6HFUCDMXQYiK60v3mtoHxAvPq7WBMrsuCEim6pna7
	vUsSm+xhfm3C8gIkL+yBfLezbQivISIIpWPgVJatQJR3HZNL3SLAfrpo2v3MNtja
	PFMtpou+wzD6cKdg54AC79PoAtAP1UGQ98S2+HBp1YrnZFQZVGdHFYqopTHoEBwh
	S+cbtrZCw8l1Qt13eKn1yZ4n7xbXplQsZFUrd9P1UHg8gM/bgYGCaHq+at9C64/4
	tOqRel8VrUr3t/0E9GHkXB0D14RU/aI7ukeXk3BTTJGR7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf7y83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Thu, 02 Oct 2025 02:05:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e1015c48c8so32587011cf.1
        for <linux-pwm@vger.kernel.org>; Wed, 01 Oct 2025 19:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370749; x=1759975549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz1KimgaPZysBciMTXlV3quW2Pafl+wJkK/SdLwaPRI=;
        b=aN0QP2oLcLXPBUiExEstaJENn42xjelHOY4Yr+XqIdrb4qjILBaQEY7vbvLGpGzLV8
         zNNa+9fSXMitEvUxRWAoulJ5jEJCSmdvm0nVKSzNZvXwHIhCV3sNeXabAFA6Gce8s6xp
         n/TAbUREfPb1Nz5k9R8DowurR3DU2MTBV7RBWDLBM6aUt7YdpYIx4R+8I+4S3ub9YCAy
         oRPaV7ObQ1f/BW1atMW0TIXhW3JfbEutd10rpjK4VG4uhU/FnzbHlq/+2JX3qOy1ugGk
         b0kondrYCAroJeB0XnEZs77EYxhCHz6qK8Mf+cemaJ8hQ8YVOLZQDUqA3edqVUCW3cXX
         DQMA==
X-Forwarded-Encrypted: i=1; AJvYcCWLjOa7KCa7cT95jKSrdx4Y3ZOnWzxiEbGCrzQ8n97z6k8DTyHoXKbLijsme0HXREQGp2yJ+CDw7i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyklHfVVsVs13x9IM/dI/ZvMvaRsEiHSy4Q/fRWITIr+Uc7seSR
	RCjHmdzl/lnXUgBrCBLMKUwAkn/Ee3oarWTyQBoV13G3es27JwgZ8+pMsMXQjD8YHryZgtFW3Ha
	/BOP9ZJgcTWMPZVxx3DazH5Pe997Sz1n8p2BwiW6FfynsyVSgxH7yCBIIIKp85XU=
X-Gm-Gg: ASbGnctMaUGbvTQAGU+qyE7wd5pOPzxEtI7SN2Z6/Qi2KWa/usQDUdvNsuqW+FaVKrW
	GSso0h+uNDIMl07HP6C+eplNqn23sLBeKH4nVgPLTW4OLwKFxvRFS7Uey3ZYhhRGu4Da2GqMwVd
	JEKJ/jnfdF1uygUaRoAZ5Y6JaJoWkc72+a3ufR9y7FaTQVfxIHw/si0FSGk4SUtaf+IFfRJ6qYf
	HmbaHczknl257yj2qMWI66scjD5hcJkn15LLaT/Wgr1cMEgk674oc8nu1lKdieDhJoicXFdxxuS
	3qUYtAi/5UbD4HHlSzE8LAGPlFvPKVhgHlfhDO8F5PFaIQ4RrEJdSVtrXUPtExYZQkQeW5tIP5d
	+Br8f3CzDXcGV5BbfU7Meg283TLTtBGd2eHBeYQX4fN27FPeVit5f+imNnw==
X-Received: by 2002:a05:622a:95:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4e563187372mr23583771cf.27.1759370748771;
        Wed, 01 Oct 2025 19:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbsN9NaYdc9BH/Kc5pOw7R8dTTMpmEEhKeBrFOgWNN/l2YW22WBhqpVIAeq3Paja6wI0ndaQ==
X-Received: by 2002:a05:622a:95:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4e563187372mr23583561cf.27.1759370748314;
        Wed, 01 Oct 2025 19:05:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444501sm3181091fa.35.2025.10.01.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:05:44 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:05:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v16 6/9] arm64: dts: qcom: ipq6018: add pwm node
Message-ID: <46ymqf46lgarsozjt23rokzoqam5xmbgt4hlz3wya5eu5fnppl@7t4ayzzkjsi4>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-6-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-6-300f237e0e68@outlook.com>
X-Proofpoint-ORIG-GUID: fYGwzoKmdUAB7Hb2piyNJKCTszgGs85W
X-Proofpoint-GUID: fYGwzoKmdUAB7Hb2piyNJKCTszgGs85W
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68ddddfd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=Lh10uZTOAAAA:8
 a=UqCG9HQmAAAA:8 a=HU31luCS42qLushI0i8A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=h7PWpkqlkWt1jHQZSjMD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX9YPcelG+qVt/
 aqylosrJpeJ9HyjRehNLismncj+wjVFAUH3Yx8W432XE27g8xU6WanvbOrmc/9DnWemlPpHZ01n
 678qO/sTyiZxi8NdLyCSBE/pS57qijSc/t/TvJO79S9In+6t4vBY6hr6YZkx94PK3qH05fq75Ue
 LOg4Vg3nxWbIx8CSlRuxz6rlIxE9XBtt17iIX3URRKgp/XyQK3ZRAhwVVP/HcZ/yGMeQQEf4jH9
 VgHA+pL7C+R8cQ+O5PjVybfn2w8Np/FPrjnmT7py7qnCkqgDNn3NVeGVDSXHptkZXI9qEGw7Q19
 5eViKuQrjIIqo3a6ZtTISXkvJkXb2Jqo/L5hIf+puf7gMpwsFFtEIKoHoavz0x5woxgbJtxAJ1y
 S6iFDfd5EtJMk+z6U4yPlVnF7S8sYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Wed, Oct 01, 2025 at 06:04:22PM +0400, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Describe the PWM block on IPQ6018.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 40f1c262126eff3761430a47472b52d27f961040..84bc2dec2b22f9634d4ec926daeebb9b40cb112f 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -413,6 +413,16 @@ tcsr: syscon@1937000 {
>  			reg = <0x0 0x01937000 0x0 0x21000>;
>  		};
>  
> +		pwm: pwm@1941010 {
> +			compatible = "qcom,ipq6018-pwm";
> +			reg = <0x01941010 0x20>;

It should be <0x0 0x01941010 0x0 0x20>;

> +			clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +			assigned-clock-rates = <100000000>;
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};
> +
>  		usb2: usb@70f8800 {
>  			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
>  			reg = <0x0 0x070f8800 0x0 0x400>;
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

