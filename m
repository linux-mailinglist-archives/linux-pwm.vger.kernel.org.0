Return-Path: <linux-pwm+bounces-8098-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMkME6Y7g2ngjwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8098-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:29:26 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E53E5CB7
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 13:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D8A304044A
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E13EDAAC;
	Wed,  4 Feb 2026 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xvz/SIeO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkuJVDN4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DB3D3307
	for <linux-pwm@vger.kernel.org>; Wed,  4 Feb 2026 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207944; cv=none; b=cGfyoYkbx0taKOe6gB9odRsFASK3LnZ0jZcteWypw6EK+YSLuqieFwvL9BvYZGwQQAWBpdC3yf/1/xCqMmSEqyiXsHgCKAKWcoUrhR12PvW1ELGTFIxGigsPQewFVmvkUv99hF+0y3hANhG98S/QaOck2mnASJpzhU8rDr+9Xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207944; c=relaxed/simple;
	bh=Vpa4oZEPwHEXNRUuwB40+XgJ/7dZ1lY+Ic4L3+YqhoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AorULUM0TCXzwzDC5jxm3XCt7xjU93iEs/WmchQM9GSEX80RMWktY1LQntAnVTPe5NxHbSli4/5K/aPmq2oGArLdnz6MWz9Najsve8l2bRpObCpon6lSN0k57IUKAJzR42focpum5N2/Ahf+cEkmJ6tm14ne4dmnJ2fVrodiorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xvz/SIeO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkuJVDN4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIal9899385
	for <linux-pwm@vger.kernel.org>; Wed, 4 Feb 2026 12:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7pWRR9YZN3Ri1woPhiOvkt+yX0CGEmyVVbUstcmldG8=; b=Xvz/SIeORgR3v2km
	0K9jULzUFndKaSgtOJ4lu+81lHNYp7GYBvZf+533Gv4G+qEHvRDd+qcLzDMLTVHJ
	1I1UnUPFI1r2VXGABm4CeTg2I1oAJ4ODyz+29fp4UxHgOTUVVSVfuqoUVw3kON9x
	6uq3i3P6qD/aBtClBTy/FanCbGb63u7DhUt6Dx4xEe7Xh32+HLoHezIIuUUc6a+7
	hZcI91gyHhfcHUfXYm8IePO5o82tRvDgFQ3Gsyf23av7Ias4MlDLYvF4uFy+I6wK
	NT5WHmLPYOxB0VGP/cq8VCZji+baq1GES1QoCkCHBlZQGxLqkOKaXg5Qopm8mFis
	H3hb1g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c445wgbjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 12:25:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c7177d4ab4so166020685a.2
        for <linux-pwm@vger.kernel.org>; Wed, 04 Feb 2026 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770207942; x=1770812742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pWRR9YZN3Ri1woPhiOvkt+yX0CGEmyVVbUstcmldG8=;
        b=IkuJVDN4I6L3rnJj3uQ5rKeiKzWbBxzh5VkedLbo3ZQYQO36CozJHf4XeHmcRPj1KE
         etfoA+pOAKzl2M+qg3Yd9QIIGnb53i0fglAw8SzZ9eOefVcg/7y8OW3jyKlq2FT/JlZM
         icC3SVnjVjCAiVnp39X6ixaeeCxOOtDLxWIFgwmnqMbty9+48XWQ21oo2+cygYrr5MED
         IQOeVNABH06o/BppD4RRTrzVOPq+lRfrtgZmKwqM+U2TjC/82Mpd8qo80EDoYcmqy35N
         ATUW2ctw2PZ2J921GHTeV9jVurGnlY9L3Lw+LhLi+0EqThnKpfojyPN1h4FkZzYybp/9
         /CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207942; x=1770812742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pWRR9YZN3Ri1woPhiOvkt+yX0CGEmyVVbUstcmldG8=;
        b=XpR91UlkBw4kb/K5PqPZETSBQwJSgkPQYuYwiS9D8CbSMEjnjmqLKj197DrGvuTR5k
         eYs1zWro6UgmiJ7jmQt9TyFwor8FAqcGDZTYR9PsYRsYkY2cCBxcNK7Jekrua0F3sRsT
         ZvTXEwGOIuai5RHVSnlw45bsbdP54o8/WtVCJWPymfwy7YJqktRajJZDPa1zoTV1KbE9
         UIogUYEqCEY13FKJbbfNwat9GcUBMKQ+nchq3NlwrgH7fN72sI1rLq7r20u8edLB7gII
         PheiQKSpqBG2puThYviVMfTTkJ9SHAruXjmXoxduayu/jSoZ4RTXECuPbLd3c/bNTtum
         OCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6NOt9gw9SSKiDibw3GtgF7poOcQ3AEotnPqZciz5cGqOchCj/UQrMazPlkQyWW9R/55Mflkg+RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjOXYKlaZFM2tiwk+MYfMhuDLUqZ65Mn+rC3brH2Bq2S54s34
	ZL/oMiiUgZ0+c4rFMESMM/gNowQHfwKE+EkEfUEk31gRGuM25CcpB2Xp2ukNQvONmTdsEeOwcLo
	2ib68plGiMSrMUMxwwt8yJOB8JMwsTTCmISkCMyWMeJjqVHbDSHtLYp5LOKZ4rac=
X-Gm-Gg: AZuq6aLqFOA+NW0TmTnuS5fiOeR0227qeHM8x7BNAXvs9IXuasShNldL7H+uJ0F5uB2
	3YPaD2aBFkDOm1bItQzn9m6Ty2yhsfL/qbzyg4p5X1OnjDAheD67o1gemSODzvH4+GO7hlXQB3q
	N+dL1q/eOi3V4rKH5tsJt6U3ZzkmDDCfllBv+/pSvwh5ELUEIA22//0gUYfg5ienUp1n3DQ4IUM
	lBbx47WjfkREyYBQZnt0p6gu0/tdSCPi1KkOo4HLLGotpxU/+XHlqGPnAM4VUkl7O6flJHyvvxv
	79FsRNmjvwPkppgchcxYJGUsnU86NtVaawrLD1RmG4RRLm6mC0p2mCIoxdIrBVEf6Tklsn9gIhj
	Tcn767Dgm5ynMvwrbYLDuTGW0aCVHGBAeLGtReRpe5zKXRTZzDdrZZ0NA4pQ5pGVVgXg=
X-Received: by 2002:a05:620a:40cd:b0:8ca:2e37:ad06 with SMTP id af79cd13be357-8ca2fa15b1dmr280287685a.10.1770207942357;
        Wed, 04 Feb 2026 04:25:42 -0800 (PST)
X-Received: by 2002:a05:620a:40cd:b0:8ca:2e37:ad06 with SMTP id af79cd13be357-8ca2fa15b1dmr280285385a.10.1770207941893;
        Wed, 04 Feb 2026 04:25:41 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0021b3bsm114669066b.49.2026.02.04.04.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 04:25:41 -0800 (PST)
Message-ID: <8cb4b755-9224-492c-955d-415585cbcf99@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 13:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 5/6] arm64: dts: qcom: ipq5332: add pwm node
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-5-91733011a3d1@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204-ipq-pwm-v20-5-91733011a3d1@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MyBTYWx0ZWRfXyH6PlaK75lPy
 gtQ1LCg6lM01NCw1gCmcxMDWdqirEzlLQIJmMW9kZmZaDwUsn6IN/l+m/YBBGYfG5vALHw8pvBV
 dfu0gzkYjx/rLvLF9x/WXs79ijqk7ZRBKTWY6BIWKzd1TAF4NcGhYriFPbEcQsUTtNymDD6/S6v
 CWPqW5yZ8JHsPL/fb1j8tBUcl1g+5ggk9j+WpYqZ3gGx7O1eOVkrnekqactIhuKykpBqFxQzfaz
 kImy0Lw0O+gicyPkMj2hUgI6rksVtYIWEjbsqS6iXN2iov8JHU5VHdhjpVPQNlJfK11cHgXUwPX
 i7cqh+sgX7UXcrbLBRMj3/e1M2CUKcdsXxXHm/ywU3cyXX8r8KgnZty0U6YHVN5ROVGDCA/EgLH
 PANY8jVOSOJlWAEiZlLYqqnNBmMgu0Bsv9mdgvlSusM8wSEPbefeFKKngq9KC+OF2wI83ASyOOd
 7pATlP/t2slCbRiJzgw==
X-Proofpoint-ORIG-GUID: Gjo3YOunyJ-q1mtsxcHpXnz7tZ5NHl1e
X-Authority-Analysis: v=2.4 cv=GvhPO01C c=1 sm=1 tr=0 ts=69833ac6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8
 a=W8KEJANZPcvdmftmyl0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Gjo3YOunyJ-q1mtsxcHpXnz7tZ5NHl1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8098-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,outlook.com:email,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,tkos.co.il];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 93E53E5CB7
X-Rspamd-Action: no action

On 2/4/26 12:25 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ5332.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

