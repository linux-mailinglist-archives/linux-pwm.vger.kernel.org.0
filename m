Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787FB49C4BE
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiAZHvw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 02:51:52 -0500
Received: from mail.schwermer.no ([49.12.228.226]:58530 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiAZHvv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 02:51:51 -0500
Message-ID: <70bfabe5-7f53-5c80-e1de-dc73e85232de@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643183509;
        bh=NAlmCNdCH1/UFtP8H5NSWDyddCGO81hUnbM+LYXGqKk=;
        h=Subject:To:Cc:References:From:In-Reply-To;
        b=qkbO6V0RwIb0ZRjpz32tIjSubsa5LTEc3ST/NBNHXpXVOw1hlubhgmLOWbD0F1h52
         3dodQ7EB5BPmUuSDkxmQgiTfscN3J8yFEcBJxlek7Yl4QJnNJ/ATz3O7YHpUENJfT3
         zDsniWeT8WSgA7eGRMG1k2//34BCI2JNHROOu52Zc1y8A9K3mi3C9ktVxOMU3/iGXM
         YFp2rMb8P+ejHn3eStvmFTP1zY/XHORNFDMMZJt0Pnct8nhAo/zy9v3OyJS4QrBASh
         jPjbzzxRcKiQHKwHEudb+e0gk2YQ8ZxW9iQ9ocD1vXTx2aS5d7T/9Uyv3nRNX+luuZ
         f1B8Ko5MSeuIw==
Date:   Wed, 26 Jan 2022 08:51:48 +0100
Mime-Version: 1.0
Subject: Re: [RFC PATCH 0/2] Multicolor PWM LED support
Content-Language: en-US
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
References: <20220125092239.2006333-1-sven@svenschwermer.de>
 <a147897a-2823-ad45-d727-0b96f48b4da3@gmail.com>
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <a147897a-2823-ad45-d727-0b96f48b4da3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jacek,

Thank you for your feedback!

On 1/25/22 23:31, Jacek Anaszewski wrote:

>>    1. Currently, the max-brightness property is expected as a property to
>>       the multi-led node. That seems consistent with the existing
>>       multicolor class code, but I'm wondering whether it would make
>>       sense to have a max-brigthness for the individual LEDs as well?
> 
> For the proper mixed color calculation all sub-leds should have
> the same max_brightness as the global max_brightness.
> 
> Look at how sub-led intensities are calculated in
> led_mc_calc_color_components().
> 
> See also [0] and [1].

OK, thanks. That makes sense.

>>    2. The current multi-led node definition calls for a node index which
>>       would in turn require the reg property to be set within the node.
>>       In this context, that doesn't seem to make sense. Should this
>>       requirement be lifted from leds-class-multicolor.yaml?
> 
> reg is required for all DT nodes with address unit in the name.
> If you skipped the address unit, then reg would be also not required.

Yes, I realize this. However, leds-class-multicolor.yaml [0] requires 
the address unit: "^multi-led@([0-9a-f])$"

Best regards,
Sven

[0] Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
