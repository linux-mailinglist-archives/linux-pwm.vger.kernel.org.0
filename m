Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2198933F
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2019 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKTPS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Aug 2019 15:15:18 -0400
Received: from vern.gendns.com ([98.142.107.122]:44090 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKTPS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 11 Aug 2019 15:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0v4NTPRprVy/Zt1y5RuGi+q3b5fOD7PiWsVJ8Qnqnh4=; b=mIr60g6iV3vi4/B/X0kemTG/+K
        9FiFiUoogvZg/oby/pTOYzhCVd3uCdEK6oyHJ0oF7njIyQH6gyBYLMb5erWKmky/lN5Or9y0aX5XJ
        10/Rt6rUMxcPl/+cMFZgsrgbg2nuhhcRK0h1QszdS9NkQgHi5AARbcIhQNsTP2lw1ORJPgbPI2TI2
        /m57C7ACnjUAYeLvSHkii15Gr5iQsNlE01E1zNIJgbMzQuYMzRH9Ba3QhGAAC/ux9F63BpjQIEPe2
        PJQLNbkGanBRARVDS5Y/Rdis8cHK6QJ3+C4Fl7FCPW0870N+r7sy5PqCEek8mN7akGe8HtwMNUOAu
        lWQwJD8Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43828 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hwtJC-0001Mn-L3; Sun, 11 Aug 2019 15:15:14 -0400
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
To:     Jonathan Cameron <jic23@kernel.org>, linux-omap@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-4-david@lechnology.com>
 <20190811102345.1af5c23c@archlinux>
From:   David Lechner <david@lechnology.com>
Message-ID: <aa307094-c205-4e68-b21f-73d27f9ee257@lechnology.com>
Date:   Sun, 11 Aug 2019 14:15:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811102345.1af5c23c@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/11/19 4:23 AM, Jonathan Cameron wrote:
> On Wed,  7 Aug 2019 14:40:21 -0500
> David Lechner <david@lechnology.com> wrote:
>> +
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_get(dev);
> I'm a little confused on the flow here.
> 
> pm_runtime_enable turns on runtime pm in general.
> 
> pm_runtime_get basically calls runtime_resume to ensrue the
> device has power.
> 
>> +
>> +	return devm_counter_register(dev, &priv->counter);
> 
> This registers the userspace interfaces and exposes the device.
> 
>> +}
>> +
>> +static int ti_eqep_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pm_runtime_put(dev),
>> +	pm_runtime_disable(dev);
> 
> pm_runtime_put notifies the system that the device is idle
> (and hence potentially turns it off).
> 
> Not good if the counter is still registered.
> 
> I'm assuming the presence of runtime pm at all is to interact
> with a parent driver and hence stop that turning off if this
> driver is probed?  That's probably fine, but add a few comments
> to make it clear that this driver itself doesn't really do
> runtime pm at all.
> 

To be honest, despite reading the runtime PM docs more than once,
I still don't feel like I have a good grasp on how it is supposed
to work. I just know that we get a crash if it is omitted because
the IP block is not powered on.

I will fix the ordering in _remove() and add a comment in v3.
