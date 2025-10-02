Return-Path: <linux-pwm+bounces-7387-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45EBB25A5
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Oct 2025 04:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5BF427BCA
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Oct 2025 02:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F1231832;
	Thu,  2 Oct 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqOkk8UG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1713C8E8
	for <linux-pwm@vger.kernel.org>; Thu,  2 Oct 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759371723; cv=none; b=hxZeABpxPUl5m/odB0QqL/IE9xI7hJI1v8rDDuyjsCYeophGf2QxjqNo1tD0KDyu65yvFvPcWgWLBE/lFMkkD+GjrroFMRet3RXpQnTQqJOyb5lJHSAC6tbIyBY0uORGEWIf6nbVddPDDTMpCtstL33ghNl+vvK4eC/lvSJ5eJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759371723; c=relaxed/simple;
	bh=R3u8F58rHAEljzf5ieZ6tcvDjFtjotWzcbHKvmj19zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAqZ9AyvVpUluJk9yl7FXsmwE6LrkCOcbi80FJZo3Bi4uYxhUxLAVTy0PYK/A84ZdVXo7x4TqBIqk32nERRZMiIisgTCo3FN/F21HNdL58DHPEL6X9/R7JdYelpFipm7Y76+lJ/SE3MaA/TQfGpI3iHHz/ZXrXljvm8UHTNWOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CqOkk8UG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic9b0017886
	for <linux-pwm@vger.kernel.org>; Thu, 2 Oct 2025 02:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=umdUQf4R0bGWG14YfjuqrsBl
	GIQNCMb9Bi3W4Jjo4VM=; b=CqOkk8UGOVZjHDAo5OEEm2yojmelwRa9YLKhHRNI
	yKKve87kzZUSbm15C7SS+aQe+qAyeIb50mpRsa+sMUQyZu2SwuX3BhoJbXFtu4eE
	Hu6aIL3TdBo+Wy38U9EY4m/sKvURXXDQJi//LU//Jm6WhEYuLy7trQsOJgw0xngJ
	eXPgupHR57fkIWwHgy1MW1AmUYunzmR8aSslaeWpLt16FmrjKf4Vzz0fQwiOogCq
	aE2wd1moYRH6mh8Q3FRnRO+PVENhUqLXDUCpZY4lMHiu6mw8fvWby5X7NKWmpeDy
	oMMFGUJ0mKyozSlao8Z+EWjJ+Ncqtswo/HiZyhfT6/3b2g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf805v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Thu, 02 Oct 2025 02:22:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df7cdf22cbso44725591cf.0
        for <linux-pwm@vger.kernel.org>; Wed, 01 Oct 2025 19:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759371720; x=1759976520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umdUQf4R0bGWG14YfjuqrsBlGIQNCMb9Bi3W4Jjo4VM=;
        b=XuBL6we8q3xAt0dwlIkXGuG9Tw2EbSRtwd5Hr3eQHvsvQHIwD8dkr7F6EORXEoNZof
         xSIWudzJNtcBoch2snGfq16U0LAP866ng68GkNffnmYglUvzAJYDhcmk/loa75HXiw6l
         CSVFY3dRomjsdGx2PgNGRWkFfLmKXANdgmDu1tjI7XQq1XlbeuxVrCkgtVFnjPIAcOxH
         j9UBwFBrwTqzDBNuGZYLTfjHcdU23k+3mxTIRxs5WIGfVVpP71wBGxYqGuQB6c8U8MF+
         NA2TlQtmEgovns9epaS3T/Ldr6WBho2mb+UMRK3utTGeQ7GVg5mz4tsYI9Tv44pSp5BJ
         1VAw==
X-Forwarded-Encrypted: i=1; AJvYcCWlLUTbwPxnLjYjg7XnnfKJlDIaSKu2wHu4g3t24k/yp4RFw940QQxbQLW850X8BPAR+nDGUmLjc4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjqzz3waLxrWnIxNm8DcVXUbvrlaIAIG5bdnwPUE6QUnbh7PBu
	EUxJw1deI5dY2n3KKPJsRgLuljh+seETOhc7+MRfqIONIrxgVGkVx4T+EFhdfF3AYX7KLRrN2LE
	KZE7Nfj4H6MXogSw9jXq1h3IA6WV5QBAN8k1cusWntKiEszwK3klWwvBS06mbvns=
X-Gm-Gg: ASbGnctROWdjqlRwIsYI4ftlkJOkdJGezSlOzxPIApxcyNHi/8HlENAplS9Nvvy2Yic
	rfKCb3J//r2ABUKtulZ95G9TRhspstYjj/I7vr3rZxPx707nCKfu/QtQSVDz1B5mXCvHSMv+t9A
	qm0GI0SoNn068gkxW8jx/OKBNHT0Hikk9eH24RGtR7W2vHYIvs/CykTg6La4mTo457KuFcdhG4v
	+UKuJ4r82WsK/tOl/4Cy87rFgSKNu42HjNOJx7WlAzn2Q8S6w4JbUADOuqar2GR7AeriTuTWXG7
	covDf0XvzQx735FuFekLyzKdhZhtpNhaxC5ZAmxbxAU/Wa4qY7b5kfyCPUy+0HyOezr5aTd5uPB
	GqMbj4q6ooJZaBbbjUR/Q2xSzZoVNe4ISYD3IwVHloQs2WGqIOuOTbZKekQ==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr27245331cf.26.1759371719973;
        Wed, 01 Oct 2025 19:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF+2h4rkzuB2BpRC2eqoMde/6sr1BdY4uOvzdxbbodL/mbH7Y0U3lM8GVcw4rutLwD5Ck66Q==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr27245051cf.26.1759371719534;
        Wed, 01 Oct 2025 19:21:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01140c6asm390391e87.56.2025.10.01.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:21:57 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:21:54 +0300
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
Subject: Re: [PATCH v16 9/9] arm64: dts: qcom: ipq9574: add pwm node
Message-ID: <zrpmbwytu4szqpwrko5jy2kk7uafabaq2lhxrwqs6g4qnfrr6h@34qy47zjmddw>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-9-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-9-300f237e0e68@outlook.com>
X-Proofpoint-ORIG-GUID: Jz79p4reRVogKc2GMyOlhtFhNyQap80Y
X-Proofpoint-GUID: Jz79p4reRVogKc2GMyOlhtFhNyQap80Y
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dde1c8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=THxROjQVSa7aAfmVI-MA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX9BbI+8cIEPU1
 puv+QLOUibYrABdsKOhNKyU8UtgxJE6t+XrVnhGPozQDy/b5FBEQPn30mqYs/TBUYBepDw8WMz/
 H7qb+udzZPt4Gv9ZaP4/S7h4ssq/4ZYyoK4F1O3ni3YbWb1NXNlAfzuzlwwryY+EJP3gp9f4qFj
 0RjRu+Jy3kbVedsxcPiMnl5SBIw147Ta/Pt6t2XPa4yzwJupuUPhp+vf86bMWL9q7tVmRnExsGN
 gTxi3Sv1FRf4r+dLYxg74A9MJWoNGxWRm8a1WX6SWs/zz+rWIjXKcApQeWhX0gkhJcKv+w22/Tq
 ocFiJjcd5riomvTudFMAmkozdvycLiHJWYPCKugDsQ+51zR4r9K0iwlQ8rUweWJJFjMSiY0sen4
 Mezuoz+NihtpU/Aki7NPrxpQdbLpTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Wed, Oct 01, 2025 at 06:04:25PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ9574.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 

-- 
With best wishes
Dmitry

