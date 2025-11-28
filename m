Return-Path: <linux-pwm+bounces-7731-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B616C91CB6
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C74E0324
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48530EF68;
	Fri, 28 Nov 2025 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRJoywFE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jzdoycil"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342462D238F
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329547; cv=none; b=NzbENZtUfyOgJW00lcyJEyNLBx4WsKvlAT9wHGb7sn3f5GTeoulCcZvQby/j7rn2DH4bFsa2Cc9BGzX0CnLA5QFi9dvc5bsTqPA869nm8sqoZ1YESbf4EvhZRCKzhSihFiW+elHzklxVfTHAeq3wvhN1vn2UhtcAWPY5Ja0Yhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329547; c=relaxed/simple;
	bh=IlGqejTxUcXaPC+LhR6zkeAqRrGA+xSroN39yUlX3vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOE50WZFkcbyJ/OWQJ5H3zBRalirtnJWs6Tt3tQn22jj8TaKBS15qpqHDdyRFVo9jYW/OtVz7VIonRZ0YZbC61KEjzmxQ6PJvT0L9BsFCXXQIrjvlX+8yAcAAJ0aCQbtTeksGUsZH/BnqSze72qTy1RhPSd6q3w6EL/s8ZGEKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PRJoywFE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jzdoycil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8Oagt3531031
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 11:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	on0p2ah52fek9cWslbKDUISLiT/n/kp65o4z/5HVnso=; b=PRJoywFEHT45aAq6
	DFXhUwLZMAqffYKbjZIUHSB+uGFmNRTDbd9+9xuJqup+VXhpu/aTIDn5xs+8A+mM
	Hak9q68lN1XVjVYVhe0AJT3Q0VRM+E+J2kKpIM57txt2XoF2tTCrol5dyseurpCr
	jiQQpMP/5cojkzTXd9s3s9JHSUEyqO+0NKExrcogp2S9boomxwOvp4Vrl82POtmy
	UOWpFfcEvszZyEUf3PvMBIryYSSohZ07gdc3UQC7L2gINrhij95Fbf33CBFYxaq6
	1HyftBUanJ4VXTVycYAj9R1DzZ17zzKHOZ972nE4LeUwZ2CaTgnFpUWJIeiBA7aI
	r3Punw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apm2rub7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 11:32:25 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dfd5a5052eso116353137.1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764329544; x=1764934344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=on0p2ah52fek9cWslbKDUISLiT/n/kp65o4z/5HVnso=;
        b=jzdoycilLzQVLMjgQdn8IuOUQrR5TKBjjF0u3WZKxedWe6E2IH3LNPWGWL3vBTBZe/
         hsEgDv8sGyn+OV3duxZbdFkNlN7ffcCYh0XYyA5pTYy8OoLbAFGOf3R2PGc7p8TOk/s9
         Z6OUpkuhlJpPY4WhTLS5OtyhC0MXBchZnXqZojliMg7VN61m8uZgWVhUuDPDF5wgIZ6o
         h524ZoOvuU1fhSufL/ARFZmGrOFVqfiRlkH7+mEgYyddP01EXbtwtN5WgMPI1ZXbQcpx
         0OX9F/QhRUzlaJCywTD/TLqN9gFxc57QOb4sOcNiif0CGY2v57Xn2HLUOeDJPv/r7h2B
         QWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764329544; x=1764934344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=on0p2ah52fek9cWslbKDUISLiT/n/kp65o4z/5HVnso=;
        b=ICPFtqFMKRuUfvy6jf/X44wk9iud7AxuT08HHOqfyo0ivAglNsvpI9rappzhgX2hoh
         vboKwPJsL3RLqH/jOe5/dMOKNhVrkcfn1S3li5M9TDlCQVAKUtarSV0kqWjFi+uNmdn0
         ksFacUpsRv9/d0q/UF/t/Crewh+Y4pNpb9gKT8YNBJp5+huaFDx8r9khOash038aI5vX
         /5NMieT2Xnjje87xr9h9TSBVxAcBnFPGnsDLa0UhkUlNq33VNp4mrOpbbbbpYVUjIrd5
         aKwPVJhXaUt5R2AfB0z1Uw531gFGiXQg9Gz15W1FBROSdvzTSHCKs76cOR2uyzQbp5YR
         lA2w==
X-Forwarded-Encrypted: i=1; AJvYcCWLJ2Y/00CS6FHtOQWJT7k2z2V7DSvqUxpTLGPIpYqOgFzuvfSiJkHUGk7Dlhlc6Y6oDblin7SfMMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpk8i3Noy/0B3ATmqpar1Qx7l8G/pN3lhhLIhSQWa3oygJIqC
	X0pN+ern1gcuJwbK+cB71iQz5MSUiSmXSCXNJVLKb+FZc7wnSsRDsv8t16eyGADebo9I2hIRrn3
	VFu0AwOZMGWFEiJdkuCVNJUTzYMOm/BC64gb3kUU4qwSTDRm0XoxnUrtOTyqP7fc=
X-Gm-Gg: ASbGncsWgrgEM8gca80jpVIihrURrDHWNbgWAtAQNmcNlFmUYN09P30dY/1iUl6cCzl
	PMv2/vfdpYrb0+puJScPo19oqVTQoXerv4L8l4nU1aWqG7zsn4gBOj53OszcGX2kQwEkY4xGQGl
	/UotwnID3XLAAxVeHj8hhRCxF1cpbag7ThjueKC2iKil2i/TV5KR4hSTwFrv6+SwWTmLKZ9brJ0
	krbBv+4evbQms2JcI+SxIssPJ0H1/P9lEeOIZg3VzJCXJxYx9rcwGjXLmzuRIGf8KFkM29m3MLW
	GUPvDoBJn4AwQ4w226C8txfpC87+7bMNhcQCSH3SC/P96CiG+hr/t6kOE/c3w6+rY5wigKdKBWl
	jppFjvCYIrj2mztJ60nmIYnT3j/pajo02vKTkcMDLHVQ2+HbXiNukb0YHyps/4dWci0c=
X-Received: by 2002:a05:6102:e12:b0:5df:b52f:58ff with SMTP id ada2fe7eead31-5e1e6a59ccemr5076349137.5.1764329544299;
        Fri, 28 Nov 2025 03:32:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVhtD3wbD8HAzB+HwO3p0fm45hGD9PrKrgX7qTDxq/Kq5y5qaWEjnnLYt3dJAVxNoxoiURPA==
X-Received: by 2002:a05:6102:e12:b0:5df:b52f:58ff with SMTP id ada2fe7eead31-5e1e6a59ccemr5076344137.5.1764329543867;
        Fri, 28 Nov 2025 03:32:23 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c68d0sm429606966b.28.2025.11.28.03.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 03:32:23 -0800 (PST)
Message-ID: <3aa86b13-9505-4f64-a168-4c46962b715e@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 12:32:21 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
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
        Baruch Siach <baruch.siach@siklu.com>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA4NCBTYWx0ZWRfX/gf0640XkGbc
 zlL7xo0H+qIbpxZT7J7UrilSpQ8BkjsiE7ni4MKPQZq1MIr5VwEx2Ah81KuYi14YWzl1x8nnZBU
 QGuC6TFD5aITE1mOSiXg/NOHPhsVOfejZn3Ss3N4J8z6/H2yKHrS+98TFGW4Jjw/cgGgxYsYQoG
 O7H2o930lBwJn8920DjPRBkhJf9GdZbGijQiz4gZ29Z1OuxGHKEHfnyJgdMlhhZfsqiH23xV+3t
 wMu0HcPV7YVgkBsHiN9yjHctEG/1QuL7+2gPcW5MjDIdSe3UCYJVehCHzXy66WS65M/QFNY046/
 WN9VtikJBlGWvt9s3ZdBKpJBtxSPxXSrHvKhSauxyHyxHzj3+spOf2i9Ca0zMXAiJvWDkE86kso
 OGxsetp0vikQbJ4hGAvvS1WJHIkxUw==
X-Proofpoint-ORIG-GUID: OvO3-aEBa27mhVP_ZiJGqE1rdOW3dt3a
X-Authority-Analysis: v=2.4 cv=W941lBWk c=1 sm=1 tr=0 ts=69298849 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=Lh10uZTOAAAA:8 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=k7Gwnk5ueRFZCsjwaScA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22 a=h7PWpkqlkWt1jHQZSjMD:22
X-Proofpoint-GUID: OvO3-aEBa27mhVP_ZiJGqE1rdOW3dt3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280084

On 11/28/25 11:29 AM, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> driver from downstream Codeaurora kernel tree. Removed support for older
> (V1) variants because I have no access to that hardware.
> 
> Tested on IPQ5018 and IPQ6010 based hardware.
> 
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +/* The frequency range supported is 1 Hz to clock rate */
> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
> +
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define IPQ_PWM_MAX_DIV		0xFFFF
> +
> +/*
> + * Two 32-bit registers for each PWM: REG0, and REG1.
> + * Base offset for PWM #i is at 8 * #i.
> + */
> +#define IPQ_PWM_REG0			0
> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
> +
> +#define IPQ_PWM_REG1			4
> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)

Sorry for coming in so late, you may consider this as material for a
follow-up patch (I *really* don't want to hold off your v19..)

I see that on ipq9574 the registers are named:

base = 0x1941010 = tcsr + 0xa010

0x0	CFG0_R0
0x4	CFG1_R0
0x8	CFG0_R1
0xc	CFG1_R1
0x10	CFG0_R2
0x14	CFG1_R2
0x18	CFG0_R3
0x1c	CFG1_R3

CFG0 and CFG1 are what you called REG0/REG1 and Rn is confusingly the
index of the controller/output

The other bits in CFG1 (29:16) are RESERVED so there's nothing you
missed in there

> +
> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to trigger the change and is unset automatically
> + * to reflect the changed divider and high duration values in register.
> + */
> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
> +
> +struct ipq_pwm_chip {
> +	struct clk *clk;
> +	void __iomem *mem;
> +};
> +
> +static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned int reg)
> +{
> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off = 8 * pwm->hwpwm + reg;

This magic 8 could be #defined as IPQ6018_PWM_CONTROLLER_STRIDE or so

Konrad

