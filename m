Return-Path: <linux-pwm+bounces-8096-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDaVK5o6g2ngjwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8096-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:24:58 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E075EE5BF7
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FA963000BA4
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BB3D525E;
	Wed,  4 Feb 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kC1SZTu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RM7VGpNa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4535C190
	for <linux-pwm@vger.kernel.org>; Wed,  4 Feb 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207893; cv=none; b=hx5ddQH/yKiGJP4ehT2/u0hx0az3xxkuL9Du+vji0K+xidGDIyEbprPb3QsJLaNoAwAl5bOIrMcXl1wVEz+1zcVG0bR7aHBt7GfgsATqHs8Andez6AFTfVWSDP3d/s6Cz5ayLPdFh4ALbNi0UXx1WKKBlXzEXk4OksAea5ANiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207893; c=relaxed/simple;
	bh=qMQadl2rnblOT8gLyMIB1TqD7Ybe4e3X33SWCp24Y9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm2zK0Li43JjDDncQqb85ZfoA7RsZLngKNC4Ub9+TzQj/dg9Q2XpTaYf1NCIUBv7tYlm/gpqDdIJavFdU3LpvWx9HwQc+R6tdCsaY9U4kuD7jewKi2elvY70xikXhNkYWHsbz/zfVzBbbM3AY2egFUX5UoBGo+5a4CMkcqhuR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kC1SZTu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RM7VGpNa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIPdu787751
	for <linux-pwm@vger.kernel.org>; Wed, 4 Feb 2026 12:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gStHw4Pb525PgjQ6MQOQm4La5fEOEM8mxRFebyrAtpE=; b=kC1SZTu1oblzgJEY
	XEniWVwviac0YLKZHW43oVvHsBD9UYm+I8g648bayrdkBmBfrpsDXz0/+qhR3s5v
	OZhUojzcA/+wGi/sccIAurDWMvxKGgvEjumoHBjFmZoDgpcb4C9K39Bg1+UoIN6F
	V3jGqbDRCxJ7P07vNm9DGTskafWlKjsUfaW0U8hDTshuENq1gerMzvbmU40FCq/n
	tFESUAFQa/Pdu1Y/ePaEOgdVXGv13nW9CvnYF4sSCJ3jiib7ie8JrfNTtLslDoUy
	x0VH1RTT8TiTCRUggrZSYeh/KehWBglXhlAlghBgakIuQrtwPBZS5jGC0jBkPTYa
	Qz5n7g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43uxge75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 12:24:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cb31bcdso164014285a.1
        for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770207892; x=1770812692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gStHw4Pb525PgjQ6MQOQm4La5fEOEM8mxRFebyrAtpE=;
        b=RM7VGpNaiAI1v0NzOU9W6JkfrUT5+d1onJPUbML8UNUIqk4U7zWv2SkFxXhFwh/5H1
         VvxH/aAcAEtXtD0ak7+PmOAC32fhM8mMr1Xe82KtjBc6pg8bDA75p9hDzGfqTtbSzlRx
         rutbCB4TF4Q5M928FBaO0ksKpOnx8VLWWZ/kZDXTgh5+K3aIqcsWiYzQRtE5SIT+z9CP
         S87zwCX5Qm85arQjYmonKL02ALv+xxlg/Qv2FWeQkBLMgkhEcnY5DvOlJqYQa+D0Ac39
         qTEhwUt8s9t2tKrqAU2cpIiM/2BL5forUSaGou5irw8R0WmX8p9GoNKR6FxxKkZ2EulE
         kBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207892; x=1770812692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gStHw4Pb525PgjQ6MQOQm4La5fEOEM8mxRFebyrAtpE=;
        b=RAmn/RWPtdI8BJWwj5IXccUOWO8TG1DccxUtW2NOrWyEdPFigcIS+4yQ0YLtdigOJC
         oedB+v5UO+aY/yr5QEt7aRj11TvdZj0+i8Jf8ISqLYGgPQ+b3Di6Cj1MDjUxAA4C99CN
         q7oJCiFVuGcllEJPdqr08/CkhnkBxjuD2mxDaFYLDMh1pCQRPmvhEMoZuNoq7DfgsA68
         aL0H3JJQ0FKQEwzZTOeMH9zs9hyM9jI/Y+GmeETJSr0xfVyzSft8oYEEOob7yXEOqqlI
         R+aPnN0/+yVz+zlbUY4UOJUtd2+JAuTmw1IGFDOsswp2vG7SqZN71SqdvZc/JN0rNS5t
         z+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0xekpcsHOlsyWp4IsLMJADDEkGz8M3ujxV+enAzn/HiiFIylx2fRpdPAdZ9injePUENlzNXy8+yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwnQ959NdEKV+YRXQ+5mV6PFmG0ImEd0fWiCL7naynOxNqJHa
	tgIe/fNChipP6Warmir7jIIFgs7fI4DdcnQVUC08Jlhlm6qJYtqlRpanrGvwTrbUCB8ifsfXNF+
	uiZ0uem8f7wQFkBJqPMG6OLaeBLoGT2JzUoxrB1tIjYYIp4+ugsyKYueM1TxdfJw=
X-Gm-Gg: AZuq6aI3QkoMbQ7gVzZgt0ba6gbP/6EEmxLzLBMyhRMQ30HHUwBjjCfitDXxmY2cE9V
	TgStjwMSEmoEajcHjCzlqQHPu0jRqvn58nXzdJuNmrY0fAOv8JZKWVfj1gbjalJaWAaLjopwu3S
	bUNketkrMdtD/VeLlHDDKYeUDoCLh55Cg0OAMTv45AwdpNxe0jozcYKWSWynmccw+8Tfmq3J6g8
	jgzKVSmaRskyt73UPCBbWeiPO+773jRLSMObcc2TVxQwjpjYOx059+HqG+DA7DXFG3zfX1QID5Q
	urMmZj5MRSWeJ6ZffcChDmYX58KSgs8JjyHxLRFiHR43f1GRBEbhxqQhA0/hGjPD3UPYXl5yZet
	12ionYiGnO5OvI4exj2oF87ZqW6gDzLmi/tk1P1l7ekD1UVj0YhCT0v8fI80z6EnOpHc=
X-Received: by 2002:a05:620a:288d:b0:8c0:c999:df5a with SMTP id af79cd13be357-8ca3311995dmr157023585a.6.1770207891814;
        Wed, 04 Feb 2026 04:24:51 -0800 (PST)
X-Received: by 2002:a05:620a:288d:b0:8c0:c999:df5a with SMTP id af79cd13be357-8ca3311995dmr157020285a.6.1770207891314;
        Wed, 04 Feb 2026 04:24:51 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0024583sm114368166b.51.2026.02.04.04.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 04:24:50 -0800 (PST)
Message-ID: <3ed170d0-3291-4cfb-b092-f4a1b2b0f96b@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 13:24:45 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 3/6] arm64: dts: qcom: ipq6018: add pwm node
To: george.moussalem@outlook.com,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        Baruch Siach
 <baruch.siach@siklu.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-3-91733011a3d1@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204-ipq-pwm-v20-3-91733011a3d1@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=StqdKfO0 c=1 sm=1 tr=0 ts=69833a94 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=Lh10uZTOAAAA:8
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=HU31luCS42qLushI0i8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=h7PWpkqlkWt1jHQZSjMD:22
X-Proofpoint-GUID: 1kRzq6B4ZWH7J11bnSIk1AXitpKIz40O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MyBTYWx0ZWRfXwkAnRmo+3M2r
 yqufny5ZTdAdbe2kaPJBwxPplHb6D52ZYxI+3JK84zb7t2fFfRxl7IEotqm3JCegknZkgLAX/HT
 enbFTdqUNMMceF/yN7UUJxYIpwy9SH9KEn+R9MhhHjx0TrvyDBH2a+RMrHbfPm2Q4HWqXzkbk70
 KqejjI+Za8bj3hm4sfm4y1KbsPE/S8Z6Fc4jL1+mH7o484q0UE63hTuIeEPumwzFxhMi+FLRE7J
 tZHtxp92I4ecKPH1NunTMK2hInFQU643vXsII0oH9hzjjCDv6bV6gasTzF2NOWyr+YDBkCtwtOw
 HM1Pf6C5J1DKaE9hLYkn8zfcc6aGNxozkjqWB717NglD7aqEkrK8n4VV4ZBZfn8ocOWXcmu5WxM
 WaC/+iAu6Fssg3HQVtqRoW2hKmZ2QXuABuXMNOfh2cXhSJ0FsQYQ2YCf8bBvyFe7FHd/EoTzq2/
 WvaeobZzEDi3jskWSsg==
X-Proofpoint-ORIG-GUID: 1kRzq6B4ZWH7J11bnSIk1AXitpKIz40O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8096-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.29.142.104:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,0.29.158.18:email,outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,siklu.com:email,quicinc.com:email];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,tkos.co.il];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E075EE5BF7
X-Rspamd-Action: no action

On 2/4/26 12:25 PM, George Moussalem via B4 Relay wrote:
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
> index 40f1c262126eff3761430a47472b52d27f961040..7866844cc09fd2c2c2f512ce2c8fa7826fabc7aa 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -413,6 +413,16 @@ tcsr: syscon@1937000 {
>  			reg = <0x0 0x01937000 0x0 0x21000>;
>  		};
>  
> +		pwm: pwm@1941010 {
> +			compatible = "qcom,ipq6018-pwm";
> +			reg = <0x0 0x01941010 0x0 0x20>;
> +			clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +			assigned-clock-rates = <100000000>;
> +			#pwm-cells = <3>;
> +			status = "disabled";

I don't think there's a reason to disable it by default, but given the
version this patchset is on, I'll be happy to see a post-merge fixup

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

