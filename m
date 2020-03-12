Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF62183087
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLMlI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 08:41:08 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:36960 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLMlI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Mar 2020 08:41:08 -0400
X-Greylist: delayed 1122 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 08:41:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lfs0z/+L0TSule7hHn2nDAOGMSOIAkxM0mBa2N+gqjI=; b=bkeEHHZBvkZiglRESydGIwO20
        weVZ3patJWJi0cvR5/syyzc+uHlgg6uan/zJcW6zVRFFRPJ6Q8bDLdr7ESeNW3hTfkxtN00/EIS+g
        l87uXsSridQ3jVJnEnD5YmkJjxlT4teuILe6lthyYHv6rnzPaeRA5nNPAXJspn7IQTlMXWYNMGj3Y
        PCtR+EF5IFvC7wu8JqK77gTwj2q5bRId7EtMRyitcz4KmX60KHs7IkC30dLI3YLdQy8n/6AGFWRdF
        eRLdCZk41tk0ZT/z4EdptxiDvMdlmDzUrlJ4zSP5B6DYkl3GvewdR/8fkpyNfeYa4qUHBRqyz1dQW
        4vUIiqu6A==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:33708 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jCMqr-002bnY-GC; Thu, 12 Mar 2020 13:22:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Mar 2020 13:22:13 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com
Subject: pwm: sun4i: pwm-backlight not working since 5.6-rc1
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi all,

I am working on adding an old A10 device to mainline and noticed an 
issue when testing on 5.5.8 vs master.

Since 5.6-rc1, I can't control the brightness of my LCD backlight 
anymore. The backlight stays on full brightness instead. I am 
controlling the brightness value via sysfs for testing.

I am not sure if this is a general pwm-sun4i issue or if it is related 
to the backlight. However I narrowed it down to one commit for 
pwm-sun4i:

fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5

If I use pwm-sun4i.c from 5b090b430d750961305030232314b6acdb0102aa on 
master, the backlight works fine. Unfortunately, due to my lack of 
kernel experience, I can't see how the commit above broke it.

Not sure if it helps, but the binding for the backlight is as follows:

backlight: backlight {
     compatible = "pwm-backlight";
     pwms = <&pwm 0 100000 PWM_POLARITY_INVERTED>;
     power-supply = <&reg_vbat>;
     enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
     brightness-levels = <0 30 40 50 60 70 80 90 100>;
     default-brightness-level = <8>;
};

Please let me know if there is anything else which might be helpful to 
know or anything I can test.

Regards,
Pascal
