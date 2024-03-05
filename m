Return-Path: <linux-pwm+bounces-1709-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCF871A1B
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 11:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62BB1F217E9
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 10:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3725380C;
	Tue,  5 Mar 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XyRejtvR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xcpE/vo/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XyRejtvR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xcpE/vo/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AB535B9;
	Tue,  5 Mar 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632862; cv=none; b=VA4Tx/d3zJ9qaEhTpnnHN6Lqp/ygRwgwwObhKyJ3dCC0suymLwa2IgSlZjKb72kW3Ll6DbNTUCsFg2DC3WzZOyTXOkJNm0jK7V4fMm8MGIon74+uHQdCgQqvMT6k9UrncyesmKykZlQVg/HVtr/dXWFQvelKC6ugCJVWfsSj1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632862; c=relaxed/simple;
	bh=g6sptkH5WsXMsGochcJACkNwyh1umsfY1H4Df2/vkhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgGgO4ATqhaP3q19NJkj3s9cwIQKW7dv7pDaJZg68cNFWzJA+xvzKYROhz6lIvc6vJ3oNfbowY4wI5Uf5z0pCNUg7LtRHfY39emsZVk+NZdyMjjbu7WSPAbfWkojkA3X/T77PI9Gsm+KaRPohaohZohPxiX+dJ4U5zrPLjPZFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XyRejtvR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xcpE/vo/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XyRejtvR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xcpE/vo/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5182E76B80;
	Tue,  5 Mar 2024 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709632858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ZNvgjCKLTo59v5cGYhNXJrpwhp2uWIuN8Ir+MiwbT0=;
	b=XyRejtvRGJX8vcMZduTnzE9Hcd1obvFQWtAZ8Br5f6pduQ0knbXb05NcLie8p11u56KxfL
	5q6+iK52U/r1tEeY+fgdf0Bb4MWwM5z429CF++sT94AARphZFC6cD8Er5rkJg3LL6a03ZV
	4n06WERnpAlXv+sfw69GKFso4Zkf2GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709632858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ZNvgjCKLTo59v5cGYhNXJrpwhp2uWIuN8Ir+MiwbT0=;
	b=xcpE/vo/bk7BfXZVch8orRTu0N4sLBMt7EMxmhN89Qx0xwLUK5r756hgdj/m35y2TaXFww
	YNR/l5MusGJh7oCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709632858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ZNvgjCKLTo59v5cGYhNXJrpwhp2uWIuN8Ir+MiwbT0=;
	b=XyRejtvRGJX8vcMZduTnzE9Hcd1obvFQWtAZ8Br5f6pduQ0knbXb05NcLie8p11u56KxfL
	5q6+iK52U/r1tEeY+fgdf0Bb4MWwM5z429CF++sT94AARphZFC6cD8Er5rkJg3LL6a03ZV
	4n06WERnpAlXv+sfw69GKFso4Zkf2GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709632858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ZNvgjCKLTo59v5cGYhNXJrpwhp2uWIuN8Ir+MiwbT0=;
	b=xcpE/vo/bk7BfXZVch8orRTu0N4sLBMt7EMxmhN89Qx0xwLUK5r756hgdj/m35y2TaXFww
	YNR/l5MusGJh7oCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA0B13A5D;
	Tue,  5 Mar 2024 10:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4TBHAVrt5mU1cQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 05 Mar 2024 10:00:58 +0000
Message-ID: <814c0da4-73f9-4260-868e-831a48fcb042@suse.de>
Date: Tue, 5 Mar 2024 11:00:57 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] backlight: Replace struct fb_info in interfaces
Content-Language: en-US
To: Lee Jones <lee@kernel.org>
Cc: andy@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240304163220.19144-1-tzimmermann@suse.de>
 <20240305093632.GC5206@google.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240305093632.GC5206@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XyRejtvR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xcpE/vo/"
X-Spamd-Result: default: False [-5.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,protonic.nl,redhat.com,lists.freedesktop.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5182E76B80
X-Spam-Level: 
X-Spam-Score: -5.30
X-Spam-Flag: NO

Hi

Am 05.03.24 um 10:36 schrieb Lee Jones:
> On Mon, 04 Mar 2024, Thomas Zimmermann wrote:
>
>> Backlight drivers implement struct backlight_ops.check_fb, which
>> uses struct fb_info in its interface. Replace the callback with one
>> that does not use fb_info.
>>
>> In DRM, we have several drivers that implement backlight support. By
>> including <linux/backlight.h> these drivers depend on <linux/fb.h>.
>> At the same time, fbdev is deprecated for new drivers and likely to
>> be replaced on many systems.
>>
>> This patchset is part of a larger effort to implement the backlight
>> code without depending on fbdev.
>>
>> Patch 1 makes the backlight core match backlight and framebuffer
>> devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
>> drivers and remove unnecessary implementations of check_fb. Finally,
>> patch 10 replaces the check_fb hook with controls_device, which
>> uses the framebuffer's Linux device instead of the framebuffer.
>>
>> v3:
>> 	* hide CONFIG_FB_BACKLIGHT behind fb_bl_device() (Lee)
>> 	* if-else cleanups (Andy)
>> 	* fix commit message of patch 2 (Andy)
>> v2:
>> 	* fix hid-picolcd for CONFIG_FB_BACKLIGHT=n
>> 	* fixes to commit messages
>>
>> Thomas Zimmermann (10):
>>    backlight: Match backlight device against struct fb_info.bl_dev
>>    auxdisplay/ht16k33: Remove struct backlight_ops.check_fb
>>    hid/hid-picolcd: Fix initialization order
>>    hid/hid-picolcd: Remove struct backlight_ops.check_fb
>>    backlight/aat2870-backlight: Remove struct backlight.check_fb
>>    backlight/pwm-backlight: Remove struct backlight_ops.check_fb
>>    fbdev/sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
>>    fbdev/ssd1307fb: Init backlight before registering framebuffer
>>    fbdev/ssd1307fb: Remove struct backlight_ops.check_fb
>>    backlight: Add controls_device callback to struct backlight_ops
>>
>>   drivers/auxdisplay/ht16k33.c             |  8 ------
>>   drivers/hid/hid-picolcd_backlight.c      |  7 ------
>>   drivers/hid/hid-picolcd_core.c           | 14 +++++------
>>   drivers/hid/hid-picolcd_fb.c             |  6 +++++
>>   drivers/video/backlight/aat2870_bl.c     |  7 ------
>>   drivers/video/backlight/backlight.c      |  8 ++++--
>>   drivers/video/backlight/bd6107.c         | 12 ++++-----
>>   drivers/video/backlight/gpio_backlight.c | 12 ++++-----
>>   drivers/video/backlight/lv5207lp.c       | 12 ++++-----
>>   drivers/video/backlight/pwm_bl.c         | 12 ---------
>>   drivers/video/fbdev/core/fb_backlight.c  |  5 ++++
>>   drivers/video/fbdev/sh_mobile_lcdcfb.c   |  7 ------
>>   drivers/video/fbdev/ssd1307fb.c          | 31 +++++++++---------------
>>   include/linux/backlight.h                | 16 ++++++------
>>   include/linux/fb.h                       |  9 +++++++
>>   include/linux/pwm_backlight.h            |  1 -
>>   16 files changed, 70 insertions(+), 97 deletions(-)
> Which Acks are you missing for us to merge this?

Only yours.

If you decide to only merge the backlight patches, I'll merge the other 
patches via other fbdev/drm trees during the next release cycle. Patch 
10/10 would afterwards go into the backlight tree again.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


