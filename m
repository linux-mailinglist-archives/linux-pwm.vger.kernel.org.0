Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB23F38CAF0
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhEUQ2C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 12:28:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61610 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234894AbhEUQ2C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 12:28:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LGGfZK005253;
        Fri, 21 May 2021 16:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=GHIetxucry4oeX0E7HvayQYx8BwaNq2x10h1Wyx1DhA=;
 b=qrRhTOwTI4CuiBXJujSfBKr9hYfEx7F0ZreCVm7e/JtkD5TKiZ3JVP2tlA4V07xedEXG
 jQxJyEht09lID+fq9lRLBxdyvKg7jO0/dlYe3y68CGwYnhHhu354lH2jGXA+x3WMQGnR
 baC3J7SjVV8A8P92taeqadqAG4EMNGBOKD/AIHZA/MIOWfNBHBPte3s/hi0u3+VkRpuh
 fW1PGvV4oS9y0qfdE5Ve4dvLlZMhD1K8By3keygHvsM8XJLpVvEpSm2PMUX4dtHrXo4e
 cOBninGp5wOqDnr8sY7ryyaRcxDnGnHHTlECuMoGu+zLMlzcmYnU32WOyr4UWD87FhtX jA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4utryjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 16:26:14 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14LGQDWv135675;
        Fri, 21 May 2021 16:26:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38meehw3ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 16:26:13 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14LGQCBQ135654;
        Fri, 21 May 2021 16:26:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38meehw3e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 16:26:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14LGQ2Qe013102;
        Fri, 21 May 2021 16:26:06 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 May 2021 09:26:02 -0700
Date:   Fri, 21 May 2021 19:25:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Ian Abbott <abbotti@mev.co.uk>,
        linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@linode1.truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210521162554.GL1955@kadam>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
 <c69d39a0-bf9e-857d-93ba-73e2884fa4ad@mev.co.uk>
 <20210521072635.GY2549456@dell>
 <20210521115431.GK1955@kadam>
 <20210521143925.xjmwluaoyer322lg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521143925.xjmwluaoyer322lg@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: ocPfLC0V13jGaBf9DUdU3_v6bNB5Rwna
X-Proofpoint-ORIG-GUID: ocPfLC0V13jGaBf9DUdU3_v6bNB5Rwna
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 21, 2021 at 04:39:25PM +0200, Uwe Kleine-König wrote:
> 
> and it built for me.

You're right.  I appologize.  I thought the linker would fail if we
had the same variable in two files but I was wrong.

regards,
dan carpenter

